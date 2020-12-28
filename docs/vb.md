# VM

* Add new VM named ubuntu-18.04.xx

    * Memory 2048MB, create a virtual harddisk now, vdi, dynamic, 30GB

* Settings

    * System, Processor->Process(s)=2

    * Storage->Controller:IDE->Empty->Select ISO

    * HDD: Solid State

    * Sharedfolder: /mnt/shared, automount

# Install ubuntu

See ubuntu_install.md

# Install guest additions

* Device->Insert Guest Addition ISO, select run

* sudo usermod -G vboxsf -a $USER

* To force it take effect without logging out

  * id -gn # current primary group name, let's say tester

  * newgrp vboxsf # switch primary group to vboxsf; new shell

  * newgrp tester # switch primary group back to tester; new shell

  * exit twice to quit the 2 new shells

* sudo shutdown -P now

* VM Setting

*   - General->Advanced->bidirectional

*   - Add shared folder as automount

* Start VM

*   - shared folder, clipboard, resize screen should work now

*   - Verify: lsmod | grep guest

# Troubleshoot

* If seeing iso9660: sudo depmod -a re-insert CD and select run


