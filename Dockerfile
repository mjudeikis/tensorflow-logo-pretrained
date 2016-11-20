FROM gcr.io/tensorflow/tensorflow:latest-devel

RUN mkdir -p /root/tf_files/logo_images
ADD logo_images /root/tf_files/logo_images

RUN cd /tensorflow; \ 
    git pull

RUN cd /tensorflow ; \
    python tensorflow/examples/image_retraining/retrain.py \
    --bottleneck_dir=$HOME/tf_files/bottlenecks \
    --model_dir=$HOME/tf_files/inception \
    --output_graph=$HOME/tf_files/retrained_graph.pb \
    --output_labels=$HOME/tf_files/retrained_labels.txt \
    --image_dir $HOME/tf_files/logo_images

COPY label_image.py /root/tf_files/
RUN ln -s /root/tf_files /tf_files