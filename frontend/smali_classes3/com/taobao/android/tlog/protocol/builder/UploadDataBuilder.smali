.class public Lcom/taobao/android/tlog/protocol/builder/UploadDataBuilder;
.super Ljava/lang/Object;
.source "UploadDataBuilder.java"


# static fields
.field private static TAG:Ljava/lang/String; = "TLOG.Protocol.UploadDataBuilder"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static buildLogUploadContent(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 50
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    invoke-static {p0}, Lcom/taobao/android/tlog/protocol/utils/Base64;->encodeBase64String([B)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
