.class public Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;
.super Ljava/lang/Object;
.source "NetworkMonitorPlugin.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Service"
.end annotation


# static fields
.field public static host:Ljava/lang/String; = null

.field public static inited:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 71
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static synthetic access$002(Z)Z
    .locals 0

    sput-boolean p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->inited:Z

    return p0
.end method

.method public static changeHost(Ljava/lang/String;)V
    .locals 1

    sput-object p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->host:Ljava/lang/String;

    sget-boolean p0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->inited:Z

    if-eqz p0, :cond_0

    .line 78
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;

    move-result-object p0

    sget-object v0, Lcom/alibaba/ha/adapter/plugin/NetworkMonitorPlugin$Service;->host:Ljava/lang/String;

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->changeHost(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public static openDebug(Z)V
    .locals 0

    return-void
.end method

.method public static openHttp(Z)V
    .locals 1

    .line 84
    :try_start_0
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->openHttp(Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method

.method public static updateUserNick(Ljava/lang/String;)V
    .locals 1

    .line 92
    :try_start_0
    invoke-static {}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;->updateUserNick(Ljava/lang/String;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method
