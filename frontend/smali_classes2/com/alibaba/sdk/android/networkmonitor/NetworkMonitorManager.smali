.class public abstract Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;
.super Ljava/lang/Object;
.source "NetworkMonitorManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;
    .locals 1

    .line 1
    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    return-object v0
.end method


# virtual methods
.method public abstract addLogger(Lcom/alibaba/sdk/android/networkmonitor/utils/Logger;)V
.end method

.method public abstract changeHost(Ljava/lang/String;)V
.end method

.method public abstract init(Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;)V
.end method

.method public abstract openHttp(Z)V
.end method

.method public abstract removeLogger(Lcom/alibaba/sdk/android/networkmonitor/utils/Logger;)V
.end method

.method public abstract setNoCollectionDataType(I)V
.end method

.method public abstract updateUserNick(Ljava/lang/String;)V
.end method
