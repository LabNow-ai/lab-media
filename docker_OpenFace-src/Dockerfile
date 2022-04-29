FROM alpine as builder
ENV DIR_DATA="/tmp/data/"
WORKDIR ${DIR_DATA}
RUN mkdir opencv dlib openface openface_model_patch_experts \
 && wget https://github.com/opencv/opencv/archive/refs/tags/4.5.5.tar.gz             -O - | tar -zx --strip-components=1 -C ./opencv   \
 && wget https://github.com/davisking/dlib/archive/refs/tags/v19.23.tar.gz           -O - | tar -zx --strip-components=1 -C ./dlib     \
 && wget https://github.com/TadasBaltrusaitis/OpenFace/archive/OpenFace_2.2.0.tar.gz -O - | tar -zx --strip-components=1 -C ./openface \
 && wget -nv https://www.dropbox.com/s/7na5qsjzz8yfoer/cen_patches_0.25_of.dat?dl=1  -O openface_model_patch_experts/cen_patches_0.25_of.dat \
 && wget -nv https://www.dropbox.com/s/k7bj804cyiu474t/cen_patches_0.35_of.dat?dl=1  -O openface_model_patch_experts/cen_patches_0.35_of.dat \
 && wget -nv https://www.dropbox.com/s/ixt4vkbmxgab1iu/cen_patches_0.50_of.dat?dl=1  -O openface_model_patch_experts/cen_patches_0.50_of.dat \
 && wget -nv https://www.dropbox.com/s/2t5t1sdpshzfhpj/cen_patches_1.00_of.dat?dl=1  -O openface_model_patch_experts/cen_patches_1.00_of.dat \
 && pwd && ls -alh && du -h -d1

FROM busybox
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
COPY --from=builder /tmp/data /home/
