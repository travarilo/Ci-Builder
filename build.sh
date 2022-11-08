#sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/bananadroid/android_manifest.git -b 13 -g default,-mips,-darwin,-notdefault
git clone https://github.com/travarilo/local_manifest --depth 1 -b master .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

source build/envsetup.sh
make clean
source build/envsetup.sh
export TZ=Asia/Jakarta
export WITH_GAPPS=true
export MINIMAL_GAPPS=true
export KBUILD_BUILD_USER=travarilo
export KBUILD_BUILD_HOST=BananaDroid
export BUILD_USERNAME=travarilo
export BUILD_HOSTNAME=BananaDroid
lunch banana_a52q-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
make bacon -j8  > reading # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
# Build BananaDroid
