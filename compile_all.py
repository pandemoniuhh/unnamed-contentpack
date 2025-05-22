import os
import subprocess
import shutil
import glob
 
def read_distribution_flag(filename="wantDistributionPayload"):
    try:
        with open(filename, "r") as file:
            return file.read().strip().lower() == "true"
    except FileNotFoundError:
        print(f"Warning: {filename} not found. Assuming distribution not wanted.")
        return False
 
def get_git_commit():
    try:
        result = subprocess.check_output(["git", "rev-parse", "--short", "HEAD"], text=True)
        return result.strip()
    except subprocess.CalledProcessError:
        print("Error: Unable to fetch Git commit ID.")
        return None
 
def compile_multifile(output_name, ext=".mf"):
    compiled_name = f"{output_name}{ext}"
    phase_folders = [f for f in glob.glob("phase_*") if os.path.isdir(f)]
    command = ["multify", "-c", "-f", compiled_name,] + phase_folders
    input("About to compile multifile. Press Enter to continue...")
    try:
        subprocess.run(command, check=True)
        return compiled_name
    except subprocess.CalledProcessError:
        print("Multify compilation failed.")
        return None
 
def main():
    print("Nai's Ultra Convenient Content Pack and Distribution Batch Script")
    print("Script converted to Python by Reia")
    print("------------------------------------------------------------------------")
 
    game_destination = os.path.join(os.getenv("LOCALAPPDATA"), "Corporate Clash", "resources", "contentpacks")
    multifile_name = "MadRayneTTCCPack"
    ext = ".mf"
    compiled_multifile = f"{multifile_name}{ext}"
 
    commit_id = get_git_commit()
    appended_mf = f"{multifile_name}_{commit_id}{ext}" if commit_id else compiled_multifile
 
    # Early file existence checks
    if os.path.exists(compiled_multifile):
        print("File already compiled!")
    elif os.path.exists(appended_mf):
        print("File is already set up for distribution.")
        print("To run this command again, either move, rename, or delete this file.")
        input("Press Enter to exit...")
        return
    else:
        compiled_result = compile_multifile(multifile_name, ext)
        if not compiled_result:
            return
 
    if read_distribution_flag():
        append_prompt = input("Compile multifile for distribution? [Y/any for N] ").strip().lower()
        if append_prompt == "y":
            if commit_id:
                print(f"Commit ID = {commit_id}")
                os.rename(compiled_multifile, appended_mf)
                print("Commit ID appended and is now ready for distribution.")
                input("Press Enter to exit...")
                return
 
    print("Proceeding to move file.")
    target_file = appended_mf if os.path.exists(appended_mf) else compiled_multifile
    print(f"Target file = {target_file}")
 
    os.makedirs(game_destination, exist_ok=True)
    try:
        shutil.move(target_file, os.path.join(game_destination, os.path.basename(target_file)))
        print("All done!")
    except FileNotFoundError:
        print("File not found during move operation.")
    except shutil.Error as e:
        print(f"Error while moving the file: {e}")
 
    input("Press Enter to exit...")
 
if __name__ == "__main__":
    main()

