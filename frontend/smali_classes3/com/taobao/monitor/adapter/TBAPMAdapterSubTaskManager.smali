.class public Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;
.super Ljava/lang/Object;
.source "TBAPMAdapterSubTaskManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;
    }
.end annotation


# static fields
.field private static isPendingState:Z

.field private static mPendingTasks:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;",
            ">;"
        }
    .end annotation
.end field

.field private static sProcedureHashMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/monitor/procedure/IProcedure;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 28
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->mPendingTasks:Ljava/util/Map;

    .line 29
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->sProcedureHashMap:Ljava/util/Map;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->isPendingState:Z

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Z
    .locals 1

    sget-boolean v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->isPendingState:Z

    return v0
.end method

.method static synthetic access$002(Z)Z
    .locals 0

    sput-boolean p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->isPendingState:Z

    return p0
.end method

.method static synthetic access$100()Ljava/util/Map;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->sProcedureHashMap:Ljava/util/Map;

    return-object v0
.end method

.method static synthetic access$200()Ljava/util/Map;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->mPendingTasks:Ljava/util/Map;

    return-object v0
.end method

.method private static async(Ljava/lang/Runnable;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "runnable"
        }
    .end annotation

    .line 160
    invoke-static {}, Lcom/taobao/monitor/ProcedureGlobal;->instance()Lcom/taobao/monitor/ProcedureGlobal;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/monitor/ProcedureGlobal;->handler()Landroid/os/Handler;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public static onEndTask(Ljava/lang/String;)V
    .locals 7
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "name"
        }
    .end annotation

    .line 75
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    .line 76
    invoke-static {}, Landroid/os/SystemClock;->currentThreadTimeMillis()J

    move-result-wide v4

    .line 78
    new-instance v6, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;

    move-object v0, v6

    move-object v1, p0

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$2;-><init>(Ljava/lang/String;JJ)V

    invoke-static {v6}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->async(Ljava/lang/Runnable;)V

    return-void
.end method

.method public static onStartTask(Ljava/lang/String;)V
    .locals 9
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x10
        }
        names = {
            "name"
        }
    .end annotation

    .line 34
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    .line 35
    invoke-static {}, Landroid/os/SystemClock;->currentThreadTimeMillis()J

    move-result-wide v4

    .line 36
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v6

    .line 37
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v0

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Looper;->getThread()Ljava/lang/Thread;

    move-result-object v1

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    move v7, v0

    .line 39
    new-instance v8, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;

    move-object v0, v8

    move-object v1, p0

    invoke-direct/range {v0 .. v7}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;-><init>(Ljava/lang/String;JJLjava/lang/String;Z)V

    invoke-static {v8}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->async(Ljava/lang/Runnable;)V

    return-void
.end method

.method protected static transferPendingTasks()V
    .locals 1

    .line 122
    new-instance v0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$3;

    invoke-direct {v0}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$3;-><init>()V

    invoke-static {v0}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;->async(Ljava/lang/Runnable;)V

    return-void
.end method
