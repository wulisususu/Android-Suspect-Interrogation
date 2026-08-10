.class public Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadCompleteReply;
.super Ljava/lang/Object;
.source "ApplyUploadCompleteReply.java"


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.Protocol.ApplyUploadCompleteReply"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/reply/ApplyUploadCompleteReply;->TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public parse(Lcom/alibaba/fastjson/JSON;Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    return-void
.end method
