.class Lanet/channel/detect/e;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lanet/channel/strategy/IStrategyListener;


# instance fields
.field final synthetic a:Lanet/channel/detect/d;


# direct methods
.method constructor <init>(Lanet/channel/detect/d;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/detect/e;->a:Lanet/channel/detect/d;

    .line 86
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onStrategyUpdated(Lanet/channel/strategy/l$d;)V
    .locals 5

    const-string v0, "anet.HorseRaceDetector"

    const-string v1, "onStrategyUpdated"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Object;

    const/4 v4, 0x0

    .line 89
    invoke-static {v0, v1, v4, v3}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 90
    invoke-static {}, Lanet/channel/AwcnConfig;->isHorseRaceEnable()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 93
    :cond_0
    iget-object v0, p1, Lanet/channel/strategy/l$d;->c:[Lanet/channel/strategy/l$c;

    if-eqz v0, :cond_3

    iget-object v0, p1, Lanet/channel/strategy/l$d;->c:[Lanet/channel/strategy/l$c;

    array-length v0, v0

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lanet/channel/detect/e;->a:Lanet/channel/detect/d;

    .line 1053
    iget-object v0, v0, Lanet/channel/detect/d;->a:Ljava/util/TreeMap;

    .line 96
    monitor-enter v0

    .line 97
    :goto_0
    :try_start_0
    iget-object v1, p1, Lanet/channel/strategy/l$d;->c:[Lanet/channel/strategy/l$c;

    array-length v1, v1

    if-ge v2, v1, :cond_2

    .line 98
    iget-object v1, p1, Lanet/channel/strategy/l$d;->c:[Lanet/channel/strategy/l$c;

    aget-object v1, v1, v2

    iget-object v3, p0, Lanet/channel/detect/e;->a:Lanet/channel/detect/d;

    .line 2053
    iget-object v3, v3, Lanet/channel/detect/d;->a:Ljava/util/TreeMap;

    .line 99
    iget-object v4, v1, Lanet/channel/strategy/l$c;->a:Ljava/lang/String;

    invoke-virtual {v3, v4, v1}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 101
    :cond_2
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p1

    :cond_3
    :goto_1
    return-void
.end method
