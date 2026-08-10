.class public Lcom/alibaba/sdk/android/oss/model/ImagePersistRequest;
.super Lcom/alibaba/sdk/android/oss/model/OSSRequest;
.source "ImagePersistRequest.java"


# instance fields
.field public mAction:Ljava/lang/String;

.field public mFromBucket:Ljava/lang/String;

.field public mFromObjectkey:Ljava/lang/String;

.field public mToBucketName:Ljava/lang/String;

.field public mToObjectKey:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 20
    invoke-direct {p0}, Lcom/alibaba/sdk/android/oss/model/OSSRequest;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/ImagePersistRequest;->mFromBucket:Ljava/lang/String;

    iput-object p2, p0, Lcom/alibaba/sdk/android/oss/model/ImagePersistRequest;->mFromObjectkey:Ljava/lang/String;

    iput-object p3, p0, Lcom/alibaba/sdk/android/oss/model/ImagePersistRequest;->mToBucketName:Ljava/lang/String;

    iput-object p4, p0, Lcom/alibaba/sdk/android/oss/model/ImagePersistRequest;->mToObjectKey:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/sdk/android/oss/model/ImagePersistRequest;->mAction:Ljava/lang/String;

    return-void
.end method
