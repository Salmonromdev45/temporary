# sync rom
repo init --depth=1 --no-repo-verify -u git://github.com/AospExtended/manifest.git -b 11.x -g default,-mips,-darwin,-notdefault
git clone https://github.com/Salmonromdev45/local_manifest.git --depth 1 -b main .repo/local_manifest
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch aosp_klteduos-userdebug
export TZ=Asia/Dhaka #put before last build command
mka aex

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
