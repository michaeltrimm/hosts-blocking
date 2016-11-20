# Backups

Before the script modifies the hosts file, a backup is taken and stored as an individual file. The naming convention is:

    host_YYYYMMDD@HHMMSS.bak

## Reverting

If you wish to revert the full changes of this script, follow these steps: 

1. If you wish to revert to the `latest.txt` file, then run

    sudo ./run.sh --undo

2. The contents of the `latest.txt` point to a file, which must exist, named something similar to the above naming convention. Those contents are the original `/etc/hosts` captured just before `--install` was executed.

3. The undo command will copy the contents of the backed up hosts file in its entirety to the `/etc/hosts` file.

4. The script will then move the filename contained inside of `latest.txt` to `hosts_YYYYMMMDD@HHMMSS.undone`

5. The script will select the last modified `backups/hosts_*.bak` file and set its filename to the contents of `latest.txt` so the `--undo` command will continue to recurisvely work backwards. 

6. When no `latest.txt` file exists, or the file the `latest.txt` file points to no longer exists, the script will error out and claim there is nothing to backup. 

    Note: If you wish to manually force the `--undo` to backup to a specific file in the `backups/*.bak` directory, you can just modify the `latest.txt` file to the filename of your choice, then run the `--undo` command. Its important to note, that automatically the next filename to be stored inside `latest.txt` will be the last created `backups/*.bak` file.


## Notes

The `latest.txt` is using string storage to point to the `hosts_*.bak` file instead of unix symbolic links. The reason for this decision is to add support for Windows 10 bash and symbolic links are handled differently in Windows than in Unix.
