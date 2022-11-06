#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/bananadroid/android_manifest.git -b 12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/IQ-7/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

source build/envsetup.sh
export TZ=Asia/Jakarta
export KBUILD_BUILD_USER=IQ-7
export KBUILD_BUILD_HOST=Corp
export BUILD_USERNAME=IQ-7
export BUILD_HOSTNAME=Corp
lunch banana_whyred-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
make bacon -j8  > reading # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# Build BananaDroid A12L
