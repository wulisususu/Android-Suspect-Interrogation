.class public Lcom/taobao/tao/log/upload/UploaderParam;
.super Lcom/taobao/android/tlog/protocol/model/CommandInfo;
.source "UploaderParam.java"


# instance fields
.field public appVersion:Ljava/lang/String;

.field public context:Landroid/content/Context;

.field public fileContentType:Ljava/lang/String;

.field public logFilePathTmp:Ljava/lang/String;

.field public params:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/model/CommandInfo;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->context:Landroid/content/Context;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->appVersion:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->logFilePathTmp:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->fileContentType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public build(Lcom/taobao/android/tlog/protocol/model/CommandInfo;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 53
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->appKey:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->appKey:Ljava/lang/String;

    .line 54
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->appId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->appId:Ljava/lang/String;

    .line 55
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->userId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->userId:Ljava/lang/String;

    .line 56
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->serviceId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->serviceId:Ljava/lang/String;

    .line 57
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->requestId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->requestId:Ljava/lang/String;

    .line 58
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->replyId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->replyId:Ljava/lang/String;

    .line 59
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->sessionId:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->sessionId:Ljava/lang/String;

    .line 60
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->replyCode:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->replyCode:Ljava/lang/String;

    .line 61
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->replyMessage:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->replyMessage:Ljava/lang/String;

    .line 62
    iget-object v0, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/tao/log/upload/UploaderParam;->opCode:Ljava/lang/String;

    .line 63
    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    iput-object p1, p0, Lcom/taobao/tao/log/upload/UploaderParam;->data:Lcom/alibaba/fastjson/JSON;

    :cond_0
    return-void
.end method
