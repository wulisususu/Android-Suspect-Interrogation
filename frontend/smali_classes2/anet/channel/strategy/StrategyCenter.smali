.class public Lanet/channel/strategy/StrategyCenter;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field private static volatile instance:Lanet/channel/strategy/IStrategyInstance;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lanet/channel/strategy/IStrategyInstance;
    .locals 2

    sget-object v0, Lanet/channel/strategy/StrategyCenter;->instance:Lanet/channel/strategy/IStrategyInstance;

    if-nez v0, :cond_1

    const-class v0, Lanet/channel/strategy/StrategyCenter;

    .line 15
    monitor-enter v0

    :try_start_0
    sget-object v1, Lanet/channel/strategy/StrategyCenter;->instance:Lanet/channel/strategy/IStrategyInstance;

    if-nez v1, :cond_0

    .line 17
    new-instance v1, Lanet/channel/strategy/g;

    invoke-direct {v1}, Lanet/channel/strategy/g;-><init>()V

    sput-object v1, Lanet/channel/strategy/StrategyCenter;->instance:Lanet/channel/strategy/IStrategyInstance;

    .line 19
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    :cond_1
    :goto_0
    sget-object v0, Lanet/channel/strategy/StrategyCenter;->instance:Lanet/channel/strategy/IStrategyInstance;

    return-object v0
.end method

.method public static setInstance(Lanet/channel/strategy/IStrategyInstance;)V
    .locals 0

    sput-object p0, Lanet/channel/strategy/StrategyCenter;->instance:Lanet/channel/strategy/IStrategyInstance;

    return-void
.end method
