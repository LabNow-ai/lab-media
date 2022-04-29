FROM alpine as builder
ENV DIR_DATA="/tmp/data/"
WORKDIR ${DIR_DATA}
RUN mkdir opencv dlib openface openface_model_patch_experts \
 && wget https://github.com/opencv/opencv/archive/refs/tags/4.5.5.tar.gz             -O - | tar -zx --strip-components=1 -C ./opencv   \
 && wget https://github.com/davisking/dlib/archive/refs/tags/v19.23.tar.gz           -O - | tar -zx --strip-components=1 -C ./dlib     \
 && wget https://github.com/TadasBaltrusaitis/OpenFace/archive/OpenFace_2.2.0.tar.gz -O - | tar -zx --strip-components=1 -C ./openface \
 # model download URLs: https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download#manual-download
 && wget -nv https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153072&authkey=AKqoZtcN0PSIZH4 -O openface_model_patch_experts/cen_patches_0.25_of.dat \
 && wget -nv https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153079&authkey=ANpDR1n3ckL_0gs -O openface_model_patch_experts/cen_patches_0.35_of.dat \
 && wget -nv https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153074&authkey=AGi-e30AfRc_zvs -O openface_model_patch_experts/cen_patches_0.50_of.dat \
 && wget -nv https://onedrive.live.com/download?cid=2E2ADA578BFF6E6E&resid=2E2ADA578BFF6E6E%2153070&authkey=AD6KjtYipphwBPc -O openface_model_patch_experts/cen_patches_1.00_of.dat \
 && pwd && ls -alh && du -h -d1

FROM busybox
CMD ["sh", "-c", "ls -alh /home && cp -r /home/* /tmp/"]
COPY --from=builder /tmp/data /home/
