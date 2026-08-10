.class public Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;
.super Ljava/util/LinkedHashMap;
.source "UploadTokenInfo.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/LinkedHashMap<",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field public fileInfo:Lcom/taobao/android/tlog/protocol/model/request/base/FileInfo;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/util/LinkedHashMap;-><init>()V

    return-void
.end method


# virtual methods
.method public set(Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;
    .locals 0

    .line 20
    invoke-virtual {p0, p1, p2}, Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object p0
.end method
