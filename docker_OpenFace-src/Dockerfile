FROM alpine as builder
ENV DIR_DATA="/tmp/data/"
WORKDIR ${DIR_DATA}
RUN mkdir opencv dlib openface openface_model_patch_experts \
 && wget https://github.com/opencv/opencv/archive/refs/tags/4.5.5.tar.gz             -O - | tar -zx --strip-components=1 -C ./opencv   \
 && wget https://github.com/davisking/dlib/archive/refs/tags/v19.23.tar.gz           -O - | tar -zx --strip-components=1 -C ./dlib     \
 && wget https://github.com/TadasBaltrusaitis/OpenFace/archive/OpenFace_2.2.0.tar.gz -O - | tar -zx --strip-components=1 -C ./openface \
 # model download URLs: https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download#manual-download
 && wget -nv https://www.dropbox.com/sh/o8g1530jle17spa/AACwK0t-CX1lAJoOAnjHcNiYa/cen_patches_0.25_of.dat?dl=0 -O openface_model_patch_experts/cen_patches_0.25_of.dat \
 && wget -nv https://www.dropbox.com/sh/o8g1530jle17spa/AADl7Ubd2T6UTUXaQVjrLWswa/cen_patches_0.35_of.dat?dl=0 -O openface_model_patch_experts/cen_patches_0.35_of.dat \
 && wget -nv https://www.dropbox.com/sh/o8g1530jle17spa/AACdS_lkcAhwDghZVq3MgMcza/cen_patches_0.50_of.dat?dl=0 -O openface_model_patch_experts/cen_patches_0.50_of.dat \
 && wget -nv https://www.dropbox.com/sh/o8g1530jle17spa/AABis9pvPp-cKI10u6McOL8-a/cen_patches_1.00_of.dat?dl=0 -O openface_model_patch_experts/cen_patches_1.00_of.dat \
 && pwd && ls -alh && du -h -d1

FROM busybox
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
COPY --from=builder /tmp/data /home/
