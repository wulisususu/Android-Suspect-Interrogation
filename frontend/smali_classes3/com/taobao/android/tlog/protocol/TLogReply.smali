.class public Lcom/taobao/android/tlog/protocol/TLogReply;
.super Ljava/lang/Object;
.source "TLogReply.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/android/tlog/protocol/TLogReply$CreateInstance;
    }
.end annotation


# instance fields
.field private TAG:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "TLogReply"

    iput-object v0, p0, Lcom/taobao/android/tlog/protocol/TLogReply;->TAG:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/android/tlog/protocol/TLogReply$1;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/taobao/android/tlog/protocol/TLogReply;-><init>()V

    return-void
.end method

.method public static declared-synchronized getInstance()Lcom/taobao/android/tlog/protocol/TLogReply;
    .locals 2

    const-class v0, Lcom/taobao/android/tlog/protocol/TLogReply;

    monitor-enter v0

    .line 34
    :try_start_0
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogReply$CreateInstance;->access$100()Lcom/taobao/android/tlog/protocol/TLogReply;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public parseCommandInfo([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/android/tlog/protocol/model/CommandInfo;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 58
    invoke-static {p2}, Lcom/alibaba/fastjson/JSON;->parseObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object p2

    .line 59
    new-instance v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    invoke-direct {v0}, Lcom/taobao/android/tlog/protocol/model/CommandInfo;-><init>()V

    .line 61
    iput-object p1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->forward:[B

    .line 62
    iput-object p4, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->serviceId:Ljava/lang/String;

    .line 63
    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->userId:Ljava/lang/String;

    const-string p1, "type"

    .line 65
    invoke-virtual {p2, p1}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_0

    .line 66
    invoke-virtual {p2, p1}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->msgType:Ljava/lang/String;

    :cond_0
    const-string p1, "headers"

    .line 69
    invoke-virtual {p2, p1}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_8

    .line 70
    invoke-virtual {p2, p1}, Lcom/alibaba/fastjson/JSONObject;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/alibaba/fastjson/JSONObject;

    const-string p3, "X-Rdwp-App-Key"

    .line 71
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_1

    .line 72
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->appKey:Ljava/lang/String;

    :cond_1
    const-string p3, "X-Rdwp-App-Id"

    .line 75
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_2

    .line 76
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->appId:Ljava/lang/String;

    :cond_2
    const-string p3, "X-Rdwp-Request-Id"

    .line 79
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_3

    .line 80
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->requestId:Ljava/lang/String;

    :cond_3
    const-string p3, "X-Rdwp-Op-Code"

    .line 82
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_4

    .line 83
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    :cond_4
    const-string p3, "X-Rdwp-Reply-Id"

    .line 85
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_5

    .line 86
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->replyId:Ljava/lang/String;

    :cond_5
    const-string p3, "X-Rdwp-Reply-Code"

    .line 88
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_6

    .line 89
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->replyCode:Ljava/lang/String;

    :cond_6
    const-string p3, "X-Rdwp-Session-Id"

    .line 91
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_7

    .line 92
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p3

    iput-object p3, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->sessionId:Ljava/lang/String;

    :cond_7
    const-string p3, "X-Rdwp-Reply-Message"

    .line 94
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p4

    if-eqz p4, :cond_8

    .line 95
    invoke-virtual {p1, p3}, Lcom/alibaba/fastjson/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->replyMessage:Ljava/lang/String;

    :cond_8
    const-string p1, "data"

    .line 99
    invoke-virtual {p2, p1}, Lcom/alibaba/fastjson/JSONObject;->containsKey(Ljava/lang/Object;)Z

    move-result p3

    if-eqz p3, :cond_9

    .line 100
    invoke-virtual {p2, p1}, Lcom/alibaba/fastjson/JSONObject;->getJSONObject(Ljava/lang/String;)Lcom/alibaba/fastjson/JSONObject;

    move-result-object p1

    iput-object p1, v0, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->data:Lcom/alibaba/fastjson/JSON;

    :cond_9
    return-object v0
.end method

.method public parseContent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)Ljava/lang/String;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 46
    invoke-static {p4}, Lcom/taobao/android/tlog/protocol/utils/Base64;->decode([B)[B

    move-result-object p1

    .line 47
    new-instance p2, Ljava/lang/String;

    const-string p3, "utf-8"

    invoke-direct {p2, p1, p3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    return-object p2
.end method
