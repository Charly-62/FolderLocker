# Folder Locker for Windows

Folder Locker is a simple batch script to lock and unlock a folder with a password. It is designed for Windows systems and has been tested on Windows 11.

## Usage

1. Download [Locker.bat](https://github.com/Charly-62/WindowsFolderLocker/blob/main/Locker.bat).

2. (Optional) Open the file with a text editor (e.g., Notepad) and check the sixth line:

   ```batch
   set "folderName=Locked Folder"
   ```

   - You can leave the folder name as `Locked Folder` if you like the default name.
   - If a folder with that name doesn’t exist, the program will automatically create it for you.
   - To use a different name, update the folder name here and save your changes.

3. Run `Locker.bat` and follow the prompts.

## Notes

- The password is stored in a hidden file: `hidden_password.txt`.
- If you forget the password, run this command in the terminal to display it:
  ```bash
  type hidden_password.txt
  ```
- If `hidden_password.txt` is deleted, recreate it using a text editor. Save the desired password inside, name it `hidden_password.txt`, and mark it as hidden:
  ```bash
  attrib +h +s hidden_password.txt
  ```

## Disclaimer

This script is for basic use on Windows systems and is not intended for securing highly sensitive data. **Use at your own risk.**
