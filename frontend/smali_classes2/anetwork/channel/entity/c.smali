.class public Lanetwork/channel/entity/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanetwork/channel/interceptor/Callback;


# instance fields
.field private a:Lanetwork/channel/aidl/ParcelableNetworkListener;

.field private b:Ljava/lang/String;

.field private c:Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;

.field private d:Z

.field private e:Lanetwork/channel/entity/g;


# direct methods
.method public constructor <init>(Lanetwork/channel/aidl/ParcelableNetworkListener;Lanetwork/channel/entity/g;)V
    .locals 1

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lanetwork/channel/entity/c;->c:Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lanetwork/channel/entity/c;->d:Z

    iput-object p1, p0, Lanetwork/channel/entity/c;->a:Lanetwork/channel/aidl/ParcelableNetworkListener;

    iput-object p2, p0, Lanetwork/channel/entity/c;->e:Lanetwork/channel/entity/g;

    if-eqz p1, :cond_0

    .line 47
    :try_start_0
    invoke-interface {p1}, Lanetwork/channel/aidl/ParcelableNetworkListener;->getListenerState()B

    move-result p1

    and-int/lit8 p1, p1, 0x8

    if-eqz p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lanetwork/channel/entity/c;->d:Z
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method static synthetic a(Lanetwork/channel/entity/c;Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;)Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;
    .locals 0

    .line 35
    iput-object p1, p0, Lanetwork/channel/entity/c;->c:Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;

    return-object p1
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 1

    iget-object v0, p0, Lanetwork/channel/entity/c;->e:Lanetwork/channel/entity/g;

    .line 222
    invoke-virtual {v0}, Lanetwork/channel/entity/g;->c()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 223
    invoke-interface {p1}, Ljava/lang/Runnable;->run()V

    goto :goto_1

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/c;->b:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 225
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Ljava/lang/Object;->hashCode()I

    move-result v0

    .line 226
    :goto_0
    invoke-static {v0, p1}, Lanetwork/channel/entity/a;->a(ILjava/lang/Runnable;)V

    :goto_1
    return-void
.end method

.method static synthetic a(Lanetwork/channel/entity/c;)Z
    .locals 0

    .line 35
    iget-boolean p0, p0, Lanetwork/channel/entity/c;->d:Z

    return p0
.end method

.method static synthetic b(Lanetwork/channel/entity/c;)Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;
    .locals 0

    .line 35
    iget-object p0, p0, Lanetwork/channel/entity/c;->c:Lanetwork/channel/aidl/adapter/ParcelableInputStreamImpl;

    return-object p0
.end method

.method static synthetic c(Lanetwork/channel/entity/c;)Lanetwork/channel/entity/g;
    .locals 0

    .line 35
    iget-object p0, p0, Lanetwork/channel/entity/c;->e:Lanetwork/channel/entity/g;

    return-object p0
.end method

.method static synthetic d(Lanetwork/channel/entity/c;)Ljava/lang/String;
    .locals 0

    .line 35
    iget-object p0, p0, Lanetwork/channel/entity/c;->b:Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lanetwork/channel/entity/c;->b:Ljava/lang/String;

    return-void
.end method

.method public onDataReceiveSize(IILanet/channel/bytes/ByteArray;)V
    .locals 7

    iget-object v5, p0, Lanetwork/channel/entity/c;->a:Lanetwork/channel/aidl/ParcelableNetworkListener;

    if-eqz v5, :cond_0

    .line 76
    new-instance v6, Lanetwork/channel/entity/e;

    move-object v0, v6

    move-object v1, p0

    move v2, p1

    move-object v3, p3

    move v4, p2

    invoke-direct/range {v0 .. v5}, Lanetwork/channel/entity/e;-><init>(Lanetwork/channel/entity/c;ILanet/channel/bytes/ByteArray;ILanetwork/channel/aidl/ParcelableNetworkListener;)V

    .line 103
    invoke-direct {p0, v6}, Lanetwork/channel/entity/c;->a(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method

.method public onFinish(Lanetwork/channel/aidl/DefaultFinishEvent;)V
    .locals 4

    const/4 v0, 0x2

    .line 108
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanetwork/channel/entity/c;->b:Ljava/lang/String;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.Repeater"

    const-string v3, "[onFinish] "

    .line 109
    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/c;->a:Lanetwork/channel/aidl/ParcelableNetworkListener;

    if-eqz v0, :cond_2

    .line 113
    new-instance v1, Lanetwork/channel/entity/f;

    invoke-direct {v1, p0, p1, v0}, Lanetwork/channel/entity/f;-><init>(Lanetwork/channel/entity/c;Lanetwork/channel/aidl/DefaultFinishEvent;Lanetwork/channel/aidl/ParcelableNetworkListener;)V

    .line 210
    iget-object p1, p1, Lanetwork/channel/aidl/DefaultFinishEvent;->rs:Lanet/channel/statist/RequestStatistic;

    if-eqz p1, :cond_1

    .line 212
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    iput-wide v2, p1, Lanet/channel/statist/RequestStatistic;->rspCbDispatch:J

    .line 214
    :cond_1
    invoke-direct {p0, v1}, Lanetwork/channel/entity/c;->a(Ljava/lang/Runnable;)V

    :cond_2
    const/4 p1, 0x0

    iput-object p1, p0, Lanetwork/channel/entity/c;->a:Lanetwork/channel/aidl/ParcelableNetworkListener;

    return-void
.end method

.method public onResponseCode(ILjava/util/Map;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;>;)V"
        }
    .end annotation

    const/4 v0, 0x2

    .line 55
    invoke-static {v0}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lanetwork/channel/entity/c;->b:Ljava/lang/String;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.Repeater"

    const-string v3, "[onResponseCode]"

    .line 56
    invoke-static {v2, v3, v0, v1}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Lanetwork/channel/entity/c;->a:Lanetwork/channel/aidl/ParcelableNetworkListener;

    if-eqz v0, :cond_1

    .line 60
    new-instance v1, Lanetwork/channel/entity/d;

    invoke-direct {v1, p0, v0, p1, p2}, Lanetwork/channel/entity/d;-><init>(Lanetwork/channel/entity/c;Lanetwork/channel/aidl/ParcelableNetworkListener;ILjava/util/Map;)V

    .line 69
    invoke-direct {p0, v1}, Lanetwork/channel/entity/c;->a(Ljava/lang/Runnable;)V

    :cond_1
    return-void
.end method
