.class public Lcom/taobao/tao/log/message/SendMessage;
.super Ljava/lang/Object;
.source "SendMessage.java"


# static fields
.field private static TAG:Ljava/lang/String; = "SendMessage"


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static pull(Landroid/content/Context;)V
    .locals 3

    .line 86
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getMessageSender()Lcom/taobao/tao/log/message/MessageSender;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 88
    new-instance v1, Lcom/taobao/tao/log/message/MessageInfo;

    invoke-direct {v1}, Lcom/taobao/tao/log/message/MessageInfo;-><init>()V

    .line 89
    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->context:Landroid/content/Context;

    .line 90
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getAppkey()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->appKey:Ljava/lang/String;

    .line 91
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getTtid()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->ttid:Ljava/lang/String;

    .line 92
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getUTDID()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->deviceId:Ljava/lang/String;

    .line 93
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRsaMd5Value()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->publicKeyDigest:Ljava/lang/String;

    .line 95
    invoke-interface {v0, v1}, Lcom/taobao/tao/log/message/MessageSender;->pullMsg(Lcom/taobao/tao/log/message/MessageInfo;)Lcom/taobao/tao/log/message/MessageReponse;

    move-result-object p0

    if-eqz p0, :cond_1

    .line 100
    iget-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "no permission"

    iget-object v1, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 101
    invoke-static {}, Lcom/taobao/tao/log/task/PullTask;->getInstance()Lcom/taobao/tao/log/task/PullTask;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/taobao/tao/log/task/PullTask;->handle(Lcom/taobao/tao/log/message/MessageReponse;)V

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/taobao/tao/log/message/SendMessage;->TAG:Ljava/lang/String;

    .line 103
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "pull request message:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object p0, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {v0, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void
.end method

.method public static send(Landroid/content/Context;Lcom/taobao/android/tlog/protocol/model/RequestResult;)V
    .locals 1

    const/4 v0, 0x0

    .line 30
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {p0, p1, v0}, Lcom/taobao/tao/log/message/SendMessage;->send(Landroid/content/Context;Lcom/taobao/android/tlog/protocol/model/RequestResult;Ljava/lang/Boolean;)V

    return-void
.end method

.method public static send(Landroid/content/Context;Lcom/taobao/android/tlog/protocol/model/RequestResult;Ljava/lang/Boolean;)V
    .locals 4

    .line 40
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object v0

    sget-object v1, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_SEND_COUNT:Ljava/lang/String;

    const-string v2, "SEND MESSAGE COUNT"

    const-string v3, "\u5f00\u59cb\u53d1\u9001\u6d88\u606f"

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageInfo(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    new-instance v0, Lcom/taobao/tao/log/message/MessageInfo;

    invoke-direct {v0}, Lcom/taobao/tao/log/message/MessageInfo;-><init>()V

    .line 45
    iput-object p0, v0, Lcom/taobao/tao/log/message/MessageInfo;->context:Landroid/content/Context;

    .line 46
    iget-object p0, p1, Lcom/taobao/android/tlog/protocol/model/RequestResult;->content:Ljava/lang/String;

    iput-object p0, v0, Lcom/taobao/tao/log/message/MessageInfo;->content:Ljava/lang/String;

    .line 47
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getAppkey()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/taobao/tao/log/message/MessageInfo;->appKey:Ljava/lang/String;

    .line 48
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getTtid()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/taobao/tao/log/message/MessageInfo;->ttid:Ljava/lang/String;

    .line 49
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getUTDID()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/taobao/tao/log/message/MessageInfo;->deviceId:Ljava/lang/String;

    .line 50
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRsaMd5Value()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v0, Lcom/taobao/tao/log/message/MessageInfo;->publicKeyDigest:Ljava/lang/String;

    .line 52
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getMessageSender()Lcom/taobao/tao/log/message/MessageSender;

    move-result-object p0

    const-string p1, "SEND MESSAGE"

    if-eqz p0, :cond_3

    .line 55
    invoke-virtual {p2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p2

    if-eqz p2, :cond_0

    .line 56
    invoke-interface {p0, v0}, Lcom/taobao/tao/log/message/MessageSender;->sendStartUp(Lcom/taobao/tao/log/message/MessageInfo;)Lcom/taobao/tao/log/message/MessageReponse;

    move-result-object p0

    goto :goto_0

    .line 58
    :cond_0
    invoke-interface {p0, v0}, Lcom/taobao/tao/log/message/MessageSender;->sendMsg(Lcom/taobao/tao/log/message/MessageInfo;)Lcom/taobao/tao/log/message/MessageReponse;

    move-result-object p0

    :goto_0
    if-eqz p0, :cond_1

    .line 61
    iget-object p2, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-nez p2, :cond_1

    const-string p2, "no permission"

    iget-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_1

    .line 62
    iget-object p1, p0, Lcom/taobao/tao/log/message/MessageReponse;->serviceId:Ljava/lang/String;

    .line 63
    iget-object p2, p0, Lcom/taobao/tao/log/message/MessageReponse;->userId:Ljava/lang/String;

    .line 64
    iget-object v0, p0, Lcom/taobao/tao/log/message/MessageReponse;->dataId:Ljava/lang/String;

    .line 65
    iget-object p0, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    .line 68
    invoke-static {}, Lcom/taobao/tao/log/CommandDataCenter;->getInstance()Lcom/taobao/tao/log/CommandDataCenter;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object p0

    invoke-virtual {v1, p1, p2, v0, p0}, Lcom/taobao/tao/log/CommandDataCenter;->onData(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[B)V

    goto :goto_2

    :cond_1
    sget-object p2, Lcom/taobao/tao/log/message/SendMessage;->TAG:Ljava/lang/String;

    .line 70
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "send request message error,result is "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    if-eqz p0, :cond_2

    iget-object p0, p0, Lcom/taobao/tao/log/message/MessageReponse;->result:Ljava/lang/String;

    goto :goto_1

    :cond_2
    const/4 p0, 0x0

    :goto_1
    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-static {p2, p0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 71
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p0

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_SEND:Ljava/lang/String;

    const-string v0, "\u53d1\u9001\u6d88\u606f\u540e\uff0c\u6536\u5230\u7684\u8fd4\u56de\u7ed3\u679c\u4e3a\u7a7a"

    invoke-interface {p0, p2, p1, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    :cond_3
    sget-object p0, Lcom/taobao/tao/log/message/SendMessage;->TAG:Ljava/lang/String;

    const-string p2, "send request message error,you neee impl message sender "

    .line 75
    invoke-static {p0, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 76
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;

    move-result-object p0

    sget-object p2, Lcom/taobao/tao/log/monitor/TLogStage;->MSG_SEND:Ljava/lang/String;

    const-string v0, "\u53d1\u9001\u6d88\u606f\u5931\u8d25\uff0c\u56e0\u4e3a\u6ca1\u6709\u5b9e\u73b0\u6d88\u606f\u670d\u52a1"

    invoke-interface {p0, p2, p1, v0}, Lcom/taobao/tao/log/monitor/TLogMonitor;->stageError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    :goto_2
    return-void
.end method

.method public static updateNick(Landroid/content/Context;)V
    .locals 2

    .line 114
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getMessageSender()Lcom/taobao/tao/log/message/MessageSender;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 116
    new-instance v1, Lcom/taobao/tao/log/message/MessageInfo;

    invoke-direct {v1}, Lcom/taobao/tao/log/message/MessageInfo;-><init>()V

    .line 117
    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->context:Landroid/content/Context;

    .line 118
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getAppkey()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->appKey:Ljava/lang/String;

    .line 119
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getUTDID()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->deviceId:Ljava/lang/String;

    .line 120
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getUserNick()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->userNick:Ljava/lang/String;

    .line 121
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object p0

    invoke-virtual {p0}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getRsaMd5Value()Ljava/lang/String;

    move-result-object p0

    iput-object p0, v1, Lcom/taobao/tao/log/message/MessageInfo;->publicKeyDigest:Ljava/lang/String;

    .line 123
    invoke-interface {v0, v1}, Lcom/taobao/tao/log/message/MessageSender;->sendUpdateNick(Lcom/taobao/tao/log/message/MessageInfo;)V

    :cond_0
    return-void
.end method
