.class public Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;
.super Ljava/lang/Object;
.source "WatchListenerAdapter.java"

# interfaces
.implements Lcom/alibaba/motu/watch/IWatchListener;


# instance fields
.field public watchListener:Lcom/alibaba/ha/adapter/service/watch/WatchListener;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/service/watch/WatchListener;)V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;->watchListener:Lcom/alibaba/ha/adapter/service/watch/WatchListener;

    return-void
.end method


# virtual methods
.method public onCatch()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;->watchListener:Lcom/alibaba/ha/adapter/service/watch/WatchListener;

    if-eqz v0, :cond_0

    .line 45
    invoke-interface {v0}, Lcom/alibaba/ha/adapter/service/watch/WatchListener;->onCatch()Ljava/util/Map;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public onListener(Ljava/util/Map;)Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;->watchListener:Lcom/alibaba/ha/adapter/service/watch/WatchListener;

    if-eqz v0, :cond_0

    .line 58
    invoke-interface {v0, p1}, Lcom/alibaba/ha/adapter/service/watch/WatchListener;->onListener(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public onWatch(Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/alibaba/ha/adapter/service/watch/WatchListenerAdapter;->watchListener:Lcom/alibaba/ha/adapter/service/watch/WatchListener;

    if-eqz v0, :cond_0

    .line 34
    invoke-interface {v0, p1}, Lcom/alibaba/ha/adapter/service/watch/WatchListener;->onWatch(Ljava/util/Map;)V

    :cond_0
    return-void
.end method
