.class public Lcom/taobao/monitor/adapter/network/TBRestSender;
.super Ljava/lang/Object;
.source "TBRestSender.java"

# interfaces
.implements Lcom/taobao/monitor/network/INetworkSender;


# static fields
.field private static final SPLIT:Ljava/lang/String; = "HA_APM_______HA_APM"

.field private static final TAG:Ljava/lang/String; = "TBRestSender"

.field private static final TRY_COUNT:I = 0x2


# instance fields
.field private final arg1:Ljava/lang/String;

.field private final eventId:Ljava/lang/Integer;

.field private hasDiskData:Z

.field private final host:Ljava/lang/String;

.field private senderDb:Lcom/taobao/monitor/adapter/network/ILiteDb;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const v0, 0xee4c

    .line 17
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->eventId:Ljava/lang/Integer;

    const-string v0, "AliHAMonitor"

    iput-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->arg1:Ljava/lang/String;

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->host:Ljava/lang/String;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->hasDiskData:Z

    .line 23
    new-instance v0, Lcom/taobao/monitor/adapter/network/SenderLiteDb;

    invoke-direct {v0}, Lcom/taobao/monitor/adapter/network/SenderLiteDb;-><init>()V

    iput-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->senderDb:Lcom/taobao/monitor/adapter/network/ILiteDb;

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/adapter/network/TBRestSender;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 0

    .line 11
    invoke-direct {p0, p1, p2}, Lcom/taobao/monitor/adapter/network/TBRestSender;->sendApmContent(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p0

    return p0
.end method

.method static synthetic access$100(Lcom/taobao/monitor/adapter/network/TBRestSender;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 11
    invoke-direct {p0, p1, p2}, Lcom/taobao/monitor/adapter/network/TBRestSender;->save2Disk(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$200(Lcom/taobao/monitor/adapter/network/TBRestSender;)Z
    .locals 0

    .line 11
    iget-boolean p0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->hasDiskData:Z

    return p0
.end method

.method static synthetic access$202(Lcom/taobao/monitor/adapter/network/TBRestSender;Z)Z
    .locals 0

    .line 11
    iput-boolean p1, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->hasDiskData:Z

    return p1
.end method

.method static synthetic access$300(Lcom/taobao/monitor/adapter/network/TBRestSender;)V
    .locals 0

    .line 11
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/network/TBRestSender;->tryLastFailedSend()V

    return-void
.end method

.method private save2Disk(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "topic",
            "content"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->senderDb:Lcom/taobao/monitor/adapter/network/ILiteDb;

    .line 82
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string v1, "HA_APM_______HA_APM"

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, p1}, Lcom/taobao/monitor/adapter/network/ILiteDb;->insert(Ljava/lang/String;)V

    return-void
.end method

.method private sendApmContent(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 10
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "topic",
            "content"
        }
    .end annotation

    .line 62
    invoke-static {}, Lcom/alibaba/sdk/android/tbrest/SendService;->getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->host:Ljava/lang/String;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->eventId:Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    const-string v6, "AliHAMonitor"

    const/4 v9, 0x0

    move-object v7, p2

    move-object v8, p1

    invoke-virtual/range {v0 .. v9}, Lcom/alibaba/sdk/android/tbrest/SendService;->sendRequest(Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    return p1
.end method

.method private tryLastFailedSend()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->senderDb:Lcom/taobao/monitor/adapter/network/ILiteDb;

    .line 67
    invoke-interface {v0}, Lcom/taobao/monitor/adapter/network/ILiteDb;->select()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 69
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    if-eqz v1, :cond_0

    const-string v2, "HA_APM_______HA_APM"

    .line 71
    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 72
    array-length v2, v1

    const/4 v3, 0x2

    if-lt v2, v3, :cond_0

    const/4 v2, 0x0

    .line 73
    aget-object v2, v1, v2

    const/4 v3, 0x1

    aget-object v1, v1, v3

    invoke-direct {p0, v2, v1}, Lcom/taobao/monitor/adapter/network/TBRestSender;->sendApmContent(Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/adapter/network/TBRestSender;->senderDb:Lcom/taobao/monitor/adapter/network/ILiteDb;

    .line 78
    invoke-interface {v0}, Lcom/taobao/monitor/adapter/network/ILiteDb;->delete()V

    return-void
.end method


# virtual methods
.method public send(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10,
            0x10
        }
        names = {
            "topic",
            "content"
        }
    .end annotation

    .line 27
    sget-boolean v0, Lcom/taobao/monitor/adapter/common/TBAPMConstants;->needUpdateData:Z

    if-nez v0, :cond_0

    return-void

    .line 29
    :cond_0
    new-instance v0, Lcom/taobao/monitor/adapter/network/TBRestSender$1;

    invoke-direct {v0, p0, p2, p1}, Lcom/taobao/monitor/adapter/network/TBRestSender$1;-><init>(Lcom/taobao/monitor/adapter/network/TBRestSender;Ljava/lang/String;Ljava/lang/String;)V

    invoke-static {v0}, Lcom/taobao/monitor/common/ThreadUtils;->start(Ljava/lang/Runnable;)V

    return-void
.end method
