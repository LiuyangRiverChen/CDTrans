model=$1
if [ ! -n "$1" ]
then 
    echo 'pelease input the model para: {deit_base, deit_small}'
    exit 8
fi
if [ $model == 'deit_base' ]
then
    model_type='uda_vit_base_patch16_224_TransReID'
    gpus="('0,1')"
else
    model='vit_small'
    model_type='uda_vit_small_patch16_224_TransReID'
    gpus="('0')"
fi
for target_dataset in 'amazon' 'dslr'
do
    python train.py --config_file configs/uda.yml MODEL.DEVICE_ID $gpus \
    OUTPUT_DIR '../logs/uda/'$model'/office/webcam2'$target_dataset \
    MODEL.PRETRAIN_PATH '../logs/pretrain/'$model'/office/Webcam/transformer_20.pth' \
    DATASETS.ROOT_TRAIN_DIR './data/office31/webcam_list.txt' \
    DATASETS.ROOT_TRAIN_DIR2 './data/office31/'$target_dataset'_list.txt' \
    DATASETS.ROOT_TEST_DIR './data/office31/'$target_dataset'_list.txt' \
    DATASETS.NAMES "Office" DATASETS.NAMES2 "Office" \
    MODEL.Transformer_TYPE $mode_type \
    SOLVER.LOG_PERIOD 10 \
    
done
