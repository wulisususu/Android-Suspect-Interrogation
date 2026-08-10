.class public Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;
.super Ljava/lang/Object;
.source "NetworkMonitorPlugin.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/AliHaPlugin;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;
    }
.end annotation


# instance fields
.field public enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

.field public mRsaPublishKey:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    new-instance v0, Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    iput-object v0, p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method


# virtual methods
.method public getName()Ljava/lang/String;
    .locals 1

    .line 22
    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

    invoke-virtual {v0}, Ljava/lang/Enum;->name()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setRsaPublishKey(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;->mRsaPublishKey:Ljava/lang/String;

    return-void
.end method

.method public start(Lcom/alibaba/ha/protocol/AliHaParam;)V
    .locals 10

    .line 31
    iget-object v0, p1, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    .line 32
    iget-object v1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->context:Landroid/content/Context;

    .line 33
    iget-object v2, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appId:Ljava/lang/String;

    .line 34
    iget-object v3, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appKey:Ljava/lang/String;

    .line 35
    iget-object v4, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appVersion:Ljava/lang/String;

    .line 36
    iget-object v5, p1, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    .line 37
    iget-object v6, p1, Lcom/alibaba/ha/protocol/AliHaParam;->userNick:Ljava/lang/String;

    .line 38
    iget-object v7, p1, Lcom/alibaba/ha/protocol/AliHaParam;->appSecret:Ljava/lang/String;

    const-string v8, "AliHaAdapter"

    if-nez v0, :cond_0

    if-eqz v1, :cond_3

    :cond_0
    if-eqz v2, :cond_3

    if-eqz v3, :cond_3

    if-eqz v7, :cond_3

    if-eqz v4, :cond_3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;->mRsaPublishKey:Ljava/lang/String;

    .line 40
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;->enabling:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v1, 0x0

    const/4 v9, 0x1

    .line 45
    invoke-virtual {v0, v1, v9}, Ljava/util/concurrent/atomic/AtomicBoolean;->compareAndSet(ZZ)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 48
    :try_start_0
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;-><init>()V

    iget-object v1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->application:Landroid/app/Application;

    .line 49
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->context(Landroid/app/Application;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    .line 50
    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->appId(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    .line 51
    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->appKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    .line 52
    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->appSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    .line 53
    invoke-virtual {v0, v4}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->appVersion(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    sget-object v1, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->host:Ljava/lang/String;

    .line 54
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->host(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    .line 55
    invoke-virtual {v0, v5}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->channel(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;->mRsaPublishKey:Ljava/lang/String;

    .line 56
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->rsaPublicKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0

    .line 57
    invoke-virtual {v0, v6}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->userNick(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 59
    :try_start_1
    iget p1, p1, Lcom/alibaba/ha/protocol/AliHaParam;->noCollectionDataType:I

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->setNoCollectionDataType(I)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 63
    :catchall_0
    :try_start_2
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->init(Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;)V

    .line 64
    invoke-static {v9}, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->access$002(Z)Z
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    const-string v0, "init networkmonitor failed. "

    .line 66
    invoke-static {v8, v0, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_2
    :goto_0
    return-void

    :cond_3
    :goto_1
    const-string p1, "param is unlegal, networkmonitor plugin start failure "

    .line 41
    invoke-static {v8, p1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
