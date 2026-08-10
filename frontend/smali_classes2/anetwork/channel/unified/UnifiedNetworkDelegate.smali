.class public abstract Lanetwork/channel/unified/UnifiedNetworkDelegate;
.super Lanetwork/channel/aidl/RemoteNetwork$Stub;
.source "Taobao"


# static fields
.field public static final DEGRADABLE:I = 0x1

.field public static final HTTP:I = 0x0

.field private static final TAG:Ljava/lang/String; = "anet.UnifiedNetworkDelegate"


# instance fields
.field public type:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 38
    invoke-direct {p0}, Lanetwork/channel/aidl/RemoteNetwork$Stub;-><init>()V

    const/4 v0, 0x1

    iput v0, p0, Lanetwork/channel/unified/UnifiedNetworkDelegate;->type:I

    .line 39
    invoke-static {p1}, Lanetwork/channel/http/NetworkSdkSetting;->init(Landroid/content/Context;)V

    return-void
.end method

.method private asyncSend(Lanetwork/channel/entity/g;Lanetwork/channel/aidl/ParcelableNetworkListener;)Lanetwork/channel/aidl/ParcelableFuture;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 59
    new-instance v0, Lanetwork/channel/unified/k;

    new-instance v1, Lanetwork/channel/entity/c;

    invoke-direct {v1, p2, p1}, Lanetwork/channel/entity/c;-><init>(Lanetwork/channel/aidl/ParcelableNetworkListener;Lanetwork/channel/entity/g;)V

    invoke-direct {v0, p1, v1}, Lanetwork/channel/unified/k;-><init>(Lanetwork/channel/entity/g;Lanetwork/channel/entity/c;)V

    .line 60
    new-instance p1, Lanetwork/channel/aidl/adapter/ParcelableFutureResponse;

    invoke-virtual {v0}, Lanetwork/channel/unified/k;->a()Ljava/util/concurrent/Future;

    move-result-object p2

    invoke-direct {p1, p2}, Lanetwork/channel/aidl/adapter/ParcelableFutureResponse;-><init>(Ljava/util/concurrent/Future;)V

    return-object p1
.end method

.method private convertToSync(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/NetworkResponse;
    .locals 7

    .line 79
    new-instance v0, Lanetwork/channel/aidl/NetworkResponse;

    invoke-direct {v0}, Lanetwork/channel/aidl/NetworkResponse;-><init>()V

    .line 81
    :try_start_0
    invoke-virtual {p0, p1}, Lanetwork/channel/unified/UnifiedNetworkDelegate;->getConnection(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/Connection;

    move-result-object p1

    check-cast p1, Lanetwork/channel/aidl/adapter/ConnectionDelegate;

    .line 83
    invoke-virtual {p1}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;->getInputStream()Lanetwork/channel/aidl/ParcelableInputStream;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 85
    new-instance v2, Ljava/io/ByteArrayOutputStream;

    invoke-interface {v1}, Lanetwork/channel/aidl/ParcelableInputStream;->length()I

    move-result v3

    if-lez v3, :cond_0

    invoke-interface {v1}, Lanetwork/channel/aidl/ParcelableInputStream;->length()I

    move-result v3

    goto :goto_0

    :cond_0
    const/16 v3, 0x400

    :goto_0
    invoke-direct {v2, v3}, Ljava/io/ByteArrayOutputStream;-><init>(I)V

    .line 1021
    sget-object v3, Lanet/channel/bytes/a$a;->a:Lanet/channel/bytes/a;

    const/16 v4, 0x800

    .line 86
    invoke-virtual {v3, v4}, Lanet/channel/bytes/a;->a(I)Lanet/channel/bytes/ByteArray;

    move-result-object v3

    .line 88
    :goto_1
    invoke-virtual {v3}, Lanet/channel/bytes/ByteArray;->getBuffer()[B

    move-result-object v4

    invoke-interface {v1, v4}, Lanetwork/channel/aidl/ParcelableInputStream;->read([B)I

    move-result v4

    const/4 v5, -0x1

    if-eq v4, v5, :cond_1

    .line 89
    invoke-virtual {v3}, Lanet/channel/bytes/ByteArray;->getBuffer()[B

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v2, v5, v6, v4}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_1

    .line 91
    :cond_1
    invoke-virtual {v2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Lanetwork/channel/aidl/NetworkResponse;->setBytedata([B)V

    .line 93
    :cond_2
    invoke-virtual {p1}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;->getStatusCode()I

    move-result v1

    if-gez v1, :cond_3

    const/4 v2, 0x0

    .line 95
    invoke-virtual {v0, v2}, Lanetwork/channel/aidl/NetworkResponse;->setBytedata([B)V

    goto :goto_2

    .line 97
    :cond_3
    invoke-virtual {p1}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;->getConnHeadFields()Ljava/util/Map;

    move-result-object v2

    invoke-virtual {v0, v2}, Lanetwork/channel/aidl/NetworkResponse;->setConnHeadFields(Ljava/util/Map;)V

    .line 99
    :goto_2
    invoke-virtual {v0, v1}, Lanetwork/channel/aidl/NetworkResponse;->setStatusCode(I)V

    .line 100
    invoke-virtual {p1}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;->getStatisticData()Lanetwork/channel/statist/StatisticData;

    move-result-object p1

    invoke-virtual {v0, p1}, Lanetwork/channel/aidl/NetworkResponse;->setStatisticData(Lanetwork/channel/statist/StatisticData;)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/16 p1, -0xc9

    .line 109
    invoke-virtual {v0, p1}, Lanetwork/channel/aidl/NetworkResponse;->setStatusCode(I)V

    goto :goto_3

    :catch_1
    move-exception p1

    const/16 v1, -0x67

    .line 103
    invoke-virtual {v0, v1}, Lanetwork/channel/aidl/NetworkResponse;->setStatusCode(I)V

    .line 104
    invoke-virtual {p1}, Landroid/os/RemoteException;->getMessage()Ljava/lang/String;

    move-result-object p1

    .line 105
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_4

    .line 106
    invoke-virtual {v0}, Lanetwork/channel/aidl/NetworkResponse;->getDesc()Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v2, "|"

    invoke-static {v1, v2, p1}, Lanet/channel/util/StringUtils;->concatString(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lanetwork/channel/aidl/NetworkResponse;->setDesc(Ljava/lang/String;)V

    :cond_4
    :goto_3
    return-object v0
.end method


# virtual methods
.method public asyncSend(Lanetwork/channel/aidl/ParcelableRequest;Lanetwork/channel/aidl/ParcelableNetworkListener;)Lanetwork/channel/aidl/ParcelableFuture;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    const/4 v0, 0x0

    .line 51
    :try_start_0
    new-instance v1, Lanetwork/channel/entity/g;

    iget v2, p0, Lanetwork/channel/unified/UnifiedNetworkDelegate;->type:I

    invoke-direct {v1, p1, v2, v0}, Lanetwork/channel/entity/g;-><init>(Lanetwork/channel/aidl/ParcelableRequest;IZ)V

    invoke-direct {p0, v1, p2}, Lanetwork/channel/unified/UnifiedNetworkDelegate;->asyncSend(Lanetwork/channel/entity/g;Lanetwork/channel/aidl/ParcelableNetworkListener;)Lanetwork/channel/aidl/ParcelableFuture;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p2

    .line 53
    iget-object p1, p1, Lanetwork/channel/aidl/ParcelableRequest;->seqNo:Ljava/lang/String;

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "anet.UnifiedNetworkDelegate"

    const-string v2, "asyncSend failed"

    invoke-static {v1, v2, p1, p2, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 54
    new-instance p1, Landroid/os/RemoteException;

    invoke-virtual {p2}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Landroid/os/RemoteException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public getConnection(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/Connection;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 66
    :try_start_0
    new-instance v0, Lanetwork/channel/entity/g;

    iget v1, p0, Lanetwork/channel/unified/UnifiedNetworkDelegate;->type:I

    const/4 v2, 0x1

    invoke-direct {v0, p1, v1, v2}, Lanetwork/channel/entity/g;-><init>(Lanetwork/channel/aidl/ParcelableRequest;IZ)V

    .line 67
    new-instance v1, Lanetwork/channel/aidl/adapter/ConnectionDelegate;

    invoke-direct {v1, v0}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;-><init>(Lanetwork/channel/entity/g;)V

    .line 68
    new-instance v2, Lanetwork/channel/aidl/adapter/ParcelableNetworkListenerWrapper;

    const/4 v3, 0x0

    invoke-direct {v2, v1, v3, v3}, Lanetwork/channel/aidl/adapter/ParcelableNetworkListenerWrapper;-><init>(Lanetwork/channel/NetworkListener;Landroid/os/Handler;Ljava/lang/Object;)V

    .line 70
    invoke-direct {p0, v0, v2}, Lanetwork/channel/unified/UnifiedNetworkDelegate;->asyncSend(Lanetwork/channel/entity/g;Lanetwork/channel/aidl/ParcelableNetworkListener;)Lanetwork/channel/aidl/ParcelableFuture;

    move-result-object v0

    invoke-virtual {v1, v0}, Lanetwork/channel/aidl/adapter/ConnectionDelegate;->setFuture(Lanetwork/channel/aidl/ParcelableFuture;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    move-exception v0

    .line 73
    iget-object p1, p1, Lanetwork/channel/aidl/ParcelableRequest;->seqNo:Ljava/lang/String;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "anet.UnifiedNetworkDelegate"

    const-string v3, "asyncSend failed"

    invoke-static {v2, v3, p1, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 74
    new-instance p1, Landroid/os/RemoteException;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Landroid/os/RemoteException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public syncSend(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/NetworkResponse;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/os/RemoteException;
        }
    .end annotation

    .line 45
    invoke-direct {p0, p1}, Lanetwork/channel/unified/UnifiedNetworkDelegate;->convertToSync(Lanetwork/channel/aidl/ParcelableRequest;)Lanetwork/channel/aidl/NetworkResponse;

    move-result-object p1

    return-object p1
.end method
