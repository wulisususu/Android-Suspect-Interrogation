.class public interface abstract Lcom/taobao/tao/log/upload/LogUploader;
.super Ljava/lang/Object;
.source "LogUploader.java"


# virtual methods
.method public abstract cancel()V
.end method

.method public abstract getUploadInfo()Lcom/taobao/tao/log/upload/UploaderInfo;
.end method

.method public abstract setMetaInfo(Ljava/util/Map;)V
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation
.end method

.method public abstract startUpload(Lcom/taobao/tao/log/upload/UploaderParam;Ljava/lang/String;Lcom/taobao/tao/log/upload/FileUploadListener;)V
.end method
