.class public Lcom/alibaba/ha/adapter/service/watch/WatchService;
.super Ljava/lang/Object;
.source "WatchService.java"


# static fields
.field public static isValid:Z = false


# direct methods
.method public static constructor <clinit>()V
    .locals 1

    :try_start_0
    const-string v0, "com.alibaba.motu.watch.MotuWatch"

    .line 18
    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/watch/WatchService;->isValid:Z
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    sput-boolean v0, Lcom/alibaba/ha/adapter/service/watch/WatchService;->isValid:Z

    :goto_0
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addWatchListener(Lcom/alibaba/ha/adapter/service/watch/WatchListener;)V
    .locals 1

    sget-boolean v0, Lcom/alibaba/ha/adapter/service/watch/WatchService;->isValid:Z

    if-nez v0, :cond_0

    return-void

    .line 34
    :cond_0
    new-instance v0, Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;

    invoke-direct {v0, p0}, Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;-><init>(Lcom/alibaba/ha/adapter/service/watch/WatchListener;)V

    .line 35
    invoke-static {}, Lcom/alibaba/motu/watch/MotuWatch;->getInstance()Lcom/alibaba/motu/watch/MotuWatch;

    move-result-object p0

    invoke-virtual {p0, v0}, Lcom/alibaba/motu/watch/MotuWatch;->setMyWatchListenerList(Lcom/alibaba/motu/watch/IWatchListener;)V

    return-void
.end method
