.class public Lcom/taobao/android/tlog/protocol/model/reply/LogConfigureReply;
.super Ljava/lang/Object;
.source "LogConfigureReply.java"


# instance fields
.field private TAG:Ljava/lang/String;

.field private replyType:Ljava/lang/String;

.field public tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

.field public tokenType:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLOG.Protocol.LogConfigureReply"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/reply/LogConfigureReply;->TAG:Ljava/lang/String;

    const-string v0, "REPLY"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/model/reply/LogConfigureReply;->replyType:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public build(Lcom/taobao/android/tlog/protocol/model/CommandInfo;Lcom/taobao/android/tlog/protocol/model/reply/base/LogReplyBaseInfo;)Ljava/lang/String;
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    if-nez p2, :cond_0

    const/4 p1, 0x0

    return-object p1

    .line 45
    :cond_0
    invoke-static {p1, p2}, Lcom/taobao/android/tlog/protocol/builder/HeaderBuilder;->buildReplyHeaders(Lcom/taobao/android/tlog/protocol/model/CommandInfo;Lcom/taobao/android/tlog/protocol/model/reply/base/LogReplyBaseInfo;)Ljava/util/Map;

    move-result-object p2

    .line 48
    new-instance v0, Lcom/alibaba/fastjson/JSONObject;

    invoke-direct {v0}, Lcom/alibaba/fastjson/JSONObject;-><init>()V

    iget-object v1, p0, Lcom/taobao/android/tlog/protocol/model/reply/LogConfigureReply;->tokenType:Ljava/lang/String;

    if-eqz v1, :cond_1

    const-string v2, "tokenType"

    .line 50
    invoke-virtual {v0, v2, v1}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    iget-object v1, p0, Lcom/taobao/android/tlog/protocol/model/reply/LogConfigureReply;->tokenInfo:Lcom/taobao/android/tlog/protocol/model/reply/base/UploadTokenInfo;

    if-eqz v1, :cond_2

    const-string v2, "tokenInfo"

    .line 53
    invoke-virtual {v0, v2, v1}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 57
    :cond_2
    new-instance v1, Lcom/alibaba/fastjson/JSONObject;

    invoke-direct {v1}, Lcom/alibaba/fastjson/JSONObject;-><init>()V

    .line 58
    iget-object v2, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->forward:[B

    if-eqz v2, :cond_3

    .line 60
    new-instance v2, Ljava/util/LinkedHashMap;

    invoke-direct {v2}, Ljava/util/LinkedHashMap;-><init>()V

    .line 61
    new-instance v3, Ljava/lang/String;

    iget-object p1, p1, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->forward:[B

    const-string v4, "utf-8"

    invoke-direct {v3, p1, v4}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    const-string p1, "content"

    invoke-interface {v2, p1, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "forward"

    .line 62
    invoke-virtual {v1, p1, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    const-string p1, "version"

    .line 64
    sget-object v2, Lcom/taobao/android/tlog/protocol/Constants;->version:Ljava/lang/Integer;

    invoke-virtual {v1, p1, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "type"

    iget-object v2, p0, Lcom/taobao/android/tlog/protocol/model/reply/LogConfigureReply;->replyType:Ljava/lang/String;

    .line 65
    invoke-virtual {v1, p1, v2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "headers"

    .line 66
    invoke-virtual {v1, p1, p2}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p1, "data"

    .line 67
    invoke-virtual {v1, p1, v0}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 70
    invoke-virtual {v1}, Lcom/alibaba/fastjson/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/android/tlog/protocol/builder/UploadDataBuilder;->buildLogUploadContent(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method
