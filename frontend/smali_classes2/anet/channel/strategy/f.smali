.class Lanet/channel/strategy/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/util/Map$Entry;

.field final synthetic b:Lanet/channel/strategy/StrategyInfoHolder$LruStrategyMap;


# direct methods
.method constructor <init>(Lanet/channel/strategy/StrategyInfoHolder$LruStrategyMap;Ljava/util/Map$Entry;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/strategy/f;->b:Lanet/channel/strategy/StrategyInfoHolder$LruStrategyMap;

    iput-object p2, p0, Lanet/channel/strategy/f;->a:Ljava/util/Map$Entry;

    .line 268
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lanet/channel/strategy/f;->a:Ljava/util/Map$Entry;

    .line 271
    invoke-interface {v0}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lanet/channel/strategy/StrategyTable;

    .line 272
    iget-boolean v1, v0, Lanet/channel/strategy/StrategyTable;->d:Z

    if-eqz v1, :cond_0

    .line 273
    new-instance v1, Lanet/channel/statist/StrategyStatObject;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Lanet/channel/statist/StrategyStatObject;-><init>(I)V

    .line 274
    iget-object v2, v0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    iput-object v2, v1, Lanet/channel/statist/StrategyStatObject;->writeStrategyFileId:Ljava/lang/String;

    iget-object v2, p0, Lanet/channel/strategy/f;->a:Ljava/util/Map$Entry;

    .line 275
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/io/Serializable;

    iget-object v3, v0, Lanet/channel/strategy/StrategyTable;->a:Ljava/lang/String;

    invoke-static {v2, v3, v1}, Lanet/channel/strategy/m;->a(Ljava/io/Serializable;Ljava/lang/String;Lanet/channel/statist/StrategyStatObject;)V

    const/4 v1, 0x0

    .line 276
    iput-boolean v1, v0, Lanet/channel/strategy/StrategyTable;->d:Z

    :cond_0
    return-void
.end method
