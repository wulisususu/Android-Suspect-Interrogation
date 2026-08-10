.class Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;
.super Ljava/lang/Object;
.source "TBAPMAdapterSubTaskManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SubTask"
.end annotation


# instance fields
.field private cpuEndTime:J

.field private cpuStartTime:J

.field private endTime:J

.field private isMainThread:Z

.field private startTime:J

.field private threadName:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$1;)V
    .locals 0

    .line 19
    invoke-direct {p0}, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;-><init>()V

    return-void
.end method

.method static synthetic access$400(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J
    .locals 2

    .line 19
    iget-wide v0, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->startTime:J

    return-wide v0
.end method

.method static synthetic access$402(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J
    .locals 0

    .line 19
    iput-wide p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->startTime:J

    return-wide p1
.end method

.method static synthetic access$500(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J
    .locals 2

    .line 19
    iget-wide v0, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->cpuStartTime:J

    return-wide v0
.end method

.method static synthetic access$502(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J
    .locals 0

    .line 19
    iput-wide p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->cpuStartTime:J

    return-wide p1
.end method

.method static synthetic access$600(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)Z
    .locals 0

    .line 19
    iget-boolean p0, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->isMainThread:Z

    return p0
.end method

.method static synthetic access$602(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;Z)Z
    .locals 0

    .line 19
    iput-boolean p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->isMainThread:Z

    return p1
.end method

.method static synthetic access$700(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)Ljava/lang/String;
    .locals 0

    .line 19
    iget-object p0, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->threadName:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$702(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;Ljava/lang/String;)Ljava/lang/String;
    .locals 0

    .line 19
    iput-object p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->threadName:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$800(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J
    .locals 2

    .line 19
    iget-wide v0, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->endTime:J

    return-wide v0
.end method

.method static synthetic access$802(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J
    .locals 0

    .line 19
    iput-wide p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->endTime:J

    return-wide p1
.end method

.method static synthetic access$900(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;)J
    .locals 2

    .line 19
    iget-wide v0, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->cpuEndTime:J

    return-wide v0
.end method

.method static synthetic access$902(Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;J)J
    .locals 0

    .line 19
    iput-wide p1, p0, Lcom/taobao/monitor/adapter/TBAPMAdapterSubTaskManager$SubTask;->cpuEndTime:J

    return-wide p1
.end method
