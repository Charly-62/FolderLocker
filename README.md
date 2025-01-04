# Folder Locker

Folder Locker is a simple batch script to lock and unlock a folder with a password.

## Usage

1. Download `Locker.bat`.
2. Open the file with a text editor (e.g., Notepad) and update the sixth line to your desired folder name:
   ```batch
   set "folderName=Locked Folder"
   ```
3. Save the changes, then run `Locker.bat` and follow the instructions.

## Notes

- The password is stored in a hidden file: `hidden_password.txt`.
- If you forget the password, you can retrieve it by running this command in the terminal where the folder is located:
  ```bash
  type hidden_password.txt
  ```

## Disclaimer

This script is for basic use. **Use at your own risk.**
