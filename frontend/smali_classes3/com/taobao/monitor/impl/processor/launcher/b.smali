.class public Lcom/taobao/monitor/impl/processor/launcher/b;
.super Lcom/taobao/monitor/impl/processor/a;
.source "LauncherProcessor.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/pageload/e$a;
.implements Lcom/taobao/monitor/impl/trace/f$b;
.implements Lcom/taobao/monitor/impl/data/h;
.implements Lcom/taobao/monitor/impl/trace/i$c;
.implements Lcom/taobao/monitor/impl/trace/e$b;
.implements Lcom/taobao/monitor/impl/trace/d$b;
.implements Lcom/taobao/monitor/impl/trace/b$c;
.implements Lcom/taobao/monitor/impl/trace/k;
.implements Lcom/taobao/monitor/impl/trace/m$b;
.implements Lcom/taobao/monitor/impl/trace/n$b;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/processor/a;",
        "Lcom/taobao/monitor/impl/processor/pageload/e$a;",
        "Lcom/taobao/monitor/impl/trace/f$b;",
        "Lcom/taobao/monitor/impl/data/h<",
        "Landroid/app/Activity;",
        ">;",
        "Lcom/taobao/monitor/impl/trace/i$c;",
        "Lcom/taobao/monitor/impl/trace/e$b;",
        "Lcom/taobao/monitor/impl/trace/d$b;",
        "Lcom/taobao/monitor/impl/trace/b$c;",
        "Lcom/taobao/monitor/impl/trace/k;",
        "Lcom/taobao/monitor/impl/trace/m$b;",
        "Lcom/taobao/monitor/impl/trace/n$b;"
    }
.end annotation


# static fields
.field public static volatile a:Ljava/lang/String; = "COLD"

.field public static b:Z = false


# instance fields
.field private a:I

.field private a:J

.field private a:Landroid/app/Activity;

.field a:Lcom/taobao/application/common/IAppLaunchListener;

.field private a:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private a:Lcom/taobao/monitor/procedure/IProcedure;

.field private a:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private a:[J

.field private b:I

.field private b:J

.field private b:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private b:Ljava/lang/String;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private c:I

.field private c:J

.field private c:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private c:Ljava/lang/String;

.field private c:Z

.field private d:I

.field private d:J

.field private d:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private d:Ljava/lang/String;

.field private volatile d:Z

.field private e:I

.field private e:J

.field private e:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private e:Z

.field private f:I

.field private f:J

.field private f:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private f:Z

.field private g:I

.field private g:J

.field private g:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private g:Z

.field private h:I

.field private h:J

.field private h:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private h:Z

.field private i:I

.field private i:Z

.field private j:I


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    const/4 v0, 0x0

    .line 1
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/a;-><init>(Z)V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    .line 14
    new-instance v1, Ljava/util/ArrayList;

    const/4 v2, 0x4

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/List;

    .line 15
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/util/List;

    iput v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:I

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Z

    .line 25
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/HashMap;

    sget-object v1, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Ljava/lang/String;

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Z

    .line 31
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IAppLaunchListener;

    move-result-object v1

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:J

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->i:Z

    return-void
.end method

.method private a()I
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Ljava/lang/String;

    const-string v1, "COLD"

    .line 47
    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method private d()V
    .locals 5

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/lang/String;

    const-string v1, "COLD"

    .line 1
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->launchStartTime:J

    goto :goto_0

    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    :goto_0
    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:J

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v1, 0x1

    .line 2
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errorCode"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    sget-object v1, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/lang/String;

    const-string v2, "launchType"

    .line 3
    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 4
    sget-boolean v1, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstInstall:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "isFirstInstall"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 5
    sget-boolean v1, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "isFirstLaunch"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 6
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->installType:Ljava/lang/String;

    const-string v2, "installType"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 7
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->oppoCPUResource:Ljava/lang/String;

    const-string v2, "oppoCPUResource"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "leaveType"

    const-string v2, "other"

    .line 8
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 9
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->lastProcessStartTime:J

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "lastProcessStartTime"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 10
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->launchStartTime:J

    sget-wide v3, Lcom/taobao/monitor/impl/data/GlobalStats;->processStartTime:J

    sub-long/2addr v1, v3

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "systemInitDuration"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 11
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->processStartTime:J

    const-string v3, "processStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 12
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->launchStartTime:J

    const-string v3, "launchStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 13
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->appConstructorEndTime:J

    const-string v3, "appConstructorEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 14
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->appAttachBaseContextStartTime:J

    const-string v3, "appAttachBaseContextStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 15
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->appAttachBaseContextEndTime:J

    const-string v3, "appAttachBaseContextEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 16
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->appOnCreateStartTime:J

    const-string v3, "appOnCreateStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 17
    sget-wide v1, Lcom/taobao/monitor/impl/data/GlobalStats;->appOnCreateEndTime:J

    const-string v3, "appOnCreateEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method private e()V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Ljava/lang/String;

    const-string v2, "COLD"

    .line 8
    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    const/4 v2, 0x1

    xor-int/2addr v1, v2

    const/4 v3, 0x4

    invoke-interface {v0, v1, v3}, Lcom/taobao/application/common/IAppLaunchListener;->onLaunchChanged(II)V

    iput-boolean v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Z

    :cond_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:I

    return-void
.end method

.method public a(I)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:I

    return-void
.end method

.method public a(IJ)V
    .locals 1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    .line 96
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 97
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "foreground2Background"

    .line 98
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 99
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->c()V

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;FJ)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 49
    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p2

    const-string v0, "onRenderPercent"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 50
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "drawPercentTime"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;IIJ)V
    .locals 3

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_1

    const/4 p1, 0x2

    if-ne p2, p1, :cond_1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v0, 0x0

    .line 56
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errorCode"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:J

    sub-long v1, p4, v1

    .line 57
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "interactiveDuration"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:J

    sub-long v1, p4, v1

    .line 58
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "launchDuration"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 59
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "deviceLevel"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 60
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->runtimeLevel:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "runtimeLevel"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 61
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfDevcie:F

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    const-string v2, "cpuUsageOfDevcie"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 62
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getMemoryInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "memoryRuntimeLevel"

    invoke-interface {p2, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 63
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const-string v1, "usableChangeType"

    invoke-interface {p2, v1, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "interactiveTime"

    .line 65
    invoke-interface {p2, p3, p4, p5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    .line 69
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->a()I

    move-result p3

    invoke-interface {p2, p3, p1}, Lcom/taobao/application/common/IAppLaunchListener;->onLaunchChanged(II)V

    .line 71
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->e()V

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:Z

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;IJ)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    const/4 v0, 0x2

    if-ne p2, v0, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    .line 79
    invoke-static {v1}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 80
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    :cond_1
    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, v1, :cond_2

    if-ne p2, v0, :cond_2

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:J

    sub-long v0, p3, v0

    .line 89
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "displayDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "displayedTime"

    .line 90
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    .line 92
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->a()I

    move-result p2

    const/4 p3, 0x1

    invoke-interface {p1, p2, p3}, Lcom/taobao/application/common/IAppLaunchListener;->onLaunchChanged(II)V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:Z

    :cond_2
    return-void
.end method

.method public a(Landroid/app/Activity;J)V
    .locals 2

    .line 13
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 14
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 15
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "pageName"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPostDestroyed"

    .line 16
    invoke-interface {p2, p3, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Z

    .line 20
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->c()V

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;JJ)V
    .locals 0

    iget-boolean p4, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Z

    if-eqz p4, :cond_0

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, p4, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide p4, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:J

    sub-long p4, p2, p4

    .line 42
    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "appInitDuration"

    invoke-interface {p1, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p4, "renderStartTime"

    .line 43
    invoke-interface {p1, p4, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Z

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/application/common/IAppLaunchListener;

    .line 46
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->a()I

    move-result p3

    invoke-interface {p2, p3, p1}, Lcom/taobao/application/common/IAppLaunchListener;->onLaunchChanged(II)V

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 2

    .line 5
    new-instance p2, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p2, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 6
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p2, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 7
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string v0, "pageName"

    invoke-virtual {p2, v0, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "onActivityPostCreated"

    .line 8
    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:J

    const-wide/16 v0, 0x0

    cmp-long p1, p1, v0

    if-nez p1, :cond_0

    iget-wide p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:J

    sub-long/2addr p3, p1

    iget-wide p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:J

    add-long/2addr p3, p1

    iput-wide p3, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 12
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "createdDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V
    .locals 3

    .line 100
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_4

    .line 105
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result v0

    .line 106
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v1

    if-nez v0, :cond_4

    const/4 v0, 0x4

    const/4 v2, 0x3

    if-eq v1, v0, :cond_1

    if-ne v1, v2, :cond_4

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 110
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 111
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    :cond_2
    const-string p1, "leaveType"

    if-ne v1, v2, :cond_3

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "home"

    .line 115
    invoke-interface {v0, p1, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    :cond_3
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "back"

    .line 117
    invoke-interface {v0, p1, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 120
    :goto_0
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 121
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p1, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 122
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const-string p3, "key"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "keyEvent"

    .line 123
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_4
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/MotionEvent;J)V
    .locals 2

    iget-boolean p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:Z

    if-eqz p2, :cond_2

    .line 23
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inBlackList(Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    return-void

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 27
    invoke-static {p2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-eqz p2, :cond_1

    .line 28
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    :cond_1
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_2

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "firstInteractiveTime"

    .line 33
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:J

    sub-long/2addr p3, v0

    .line 34
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "firstInteractiveDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "leaveType"

    const-string p3, "touch"

    .line 35
    invoke-interface {p1, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p2, 0x0

    .line 36
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const-string p4, "errorCode"

    invoke-interface {p1, p4, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-boolean p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:Z

    :cond_2
    return-void
.end method

.method public a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V
    .locals 1

    if-nez p2, :cond_0

    return-void

    :cond_0
    if-nez p1, :cond_1

    return-void

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-eq p1, v0, :cond_2

    return-void

    .line 126
    :cond_2
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    .line 127
    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, "_"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/HashMap;

    .line 129
    invoke-virtual {p2, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/Integer;

    if-nez p2, :cond_3

    const/4 p2, 0x0

    .line 131
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    goto :goto_0

    .line 133
    :cond_3
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    add-int/lit8 p2, p2, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    :goto_0
    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/HashMap;

    .line 135
    invoke-virtual {p3, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 136
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p3, p1, p4, p5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;FJ)V
    .locals 0

    .line 1
    check-cast p1, Landroid/app/Activity;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/launcher/b;->a(Landroid/app/Activity;FJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IIJ)V
    .locals 0

    .line 3
    check-cast p1, Landroid/app/Activity;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/launcher/b;->a(Landroid/app/Activity;IIJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IJ)V
    .locals 0

    .line 4
    check-cast p1, Landroid/app/Activity;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/launcher/b;->a(Landroid/app/Activity;IJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;JJ)V
    .locals 0

    .line 2
    check-cast p1, Landroid/app/Activity;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/launcher/b;->a(Landroid/app/Activity;JJ)V

    return-void
.end method

.method protected b()V
    .locals 5

    .line 1
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->b()V

    .line 3
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:[J

    .line 4
    new-instance v0, Lcom/taobao/application/common/data/c;

    invoke-direct {v0}, Lcom/taobao/application/common/data/c;-><init>()V

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/c;->a(Ljava/lang/String;)V

    .line 6
    sget-object v0, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getLauncherProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 7
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->isAlive()Z

    move-result v0

    if-nez v0, :cond_1

    .line 8
    :cond_0
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    .line 9
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v2, 0x1

    .line 10
    invoke-virtual {v0, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 11
    invoke-virtual {v0, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v2, 0x0

    .line 12
    invoke-virtual {v0, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 13
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 15
    sget-object v2, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    const-string v3, "/startup"

    invoke-static {v3}, Lcom/taobao/monitor/impl/util/TopicUtils;->getFullTopic(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 16
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    .line 17
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object v0

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {v0, v2}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentLauncherProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 20
    :cond_1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v4, "procedureStartTime"

    .line 21
    invoke-interface {v0, v4, v2, v3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "ACTIVITY_EVENT_DISPATCHER"

    .line 23
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_LOW_MEMORY_DISPATCHER"

    .line 24
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_USABLE_VISIBLE_DISPATCHER"

    .line 25
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_FPS_DISPATCHER"

    .line 26
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_GC_DISPATCHER"

    .line 27
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 28
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "NETWORK_STAGE_DISPATCHER"

    .line 29
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "IMAGE_STAGE_DISPATCHER"

    .line 30
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 32
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 33
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 34
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 35
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 36
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 37
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 38
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 39
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    .line 40
    sget-object v0, Lcom/taobao/monitor/impl/trace/j;->a:Lcom/taobao/monitor/impl/trace/j;

    invoke-virtual {v0, p0}, Lcom/taobao/monitor/impl/trace/a;->addListener(Ljava/lang/Object;)V

    .line 42
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->d()V

    sput-boolean v1, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Z

    return-void
.end method

.method public b(I)V
    .locals 2

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->i:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->i:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->j:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->j:I

    :cond_3
    :goto_0
    return-void
.end method

.method public b(Landroid/app/Activity;J)V
    .locals 4

    .line 95
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 96
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 97
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string v1, "pageName"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityResumed"

    .line 98
    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 100
    sget-boolean p1, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "resumedTime"

    .line 102
    invoke-interface {p1, v0, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public b(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 3

    .line 44
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    .line 45
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Z

    if-nez v0, :cond_3

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    if-nez v0, :cond_0

    .line 50
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->b()V

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 53
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const-string v2, "systemRecovery"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    sget-object v0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/lang/String;

    const-string v1, "COLD"

    .line 54
    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    .line 56
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->lastTopActivity:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 57
    sget-object v1, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/List;

    .line 59
    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 63
    :cond_1
    invoke-virtual {p1}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    if-eqz p1, :cond_2

    .line 65
    invoke-virtual {p1}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object p1

    .line 66
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "schemaUrl"

    .line 67
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_2
    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "firstPageName"

    .line 70
    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "firstPageCreateTime"

    .line 71
    invoke-interface {p1, v0, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    sget-object p1, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/lang/String;

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Ljava/lang/String;

    const-string p1, "HOT"

    sput-object p1, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Z

    :cond_3
    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/List;

    .line 78
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result p1

    const/16 v0, 0xa

    if-ge p1, v0, :cond_4

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 80
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_4

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/List;

    .line 81
    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_4
    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 85
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_6

    .line 86
    invoke-static {}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->isWhiteListEmpty()Z

    move-result p1

    if-nez p1, :cond_5

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    invoke-static {p1}, Lcom/taobao/monitor/impl/processor/launcher/PageList;->inWhiteList(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    :cond_5
    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Ljava/lang/String;

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 91
    :cond_6
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 92
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p1, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string p3, "pageName"

    .line 93
    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityCreated"

    .line 94
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method protected c()V
    .locals 9

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->i:Z

    if-nez v0, :cond_1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->i:Z

    .line 18
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->e()V

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    .line 20
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    const-string v2, "."

    .line 21
    invoke-virtual {v1, v2}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    add-int/2addr v1, v0

    .line 22
    invoke-virtual {v2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "currentPageName"

    .line 23
    invoke-interface {v2, v3, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/lang/String;

    const-string v3, "fullPageName"

    .line 24
    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/List;

    .line 26
    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "linkPageName"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Ljava/util/List;

    .line 27
    invoke-interface {v1}, Ljava/util/List;->clear()V

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 29
    sget-boolean v2, Lcom/taobao/monitor/impl/data/GlobalStats;->hasSplash:Z

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    const-string v3, "hasSplash"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:I

    .line 30
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "gcCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/util/List;

    .line 31
    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "fps"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:I

    .line 32
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "jankCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:I

    .line 34
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "image"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:I

    .line 35
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "imageOnRequest"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:I

    .line 36
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "imageSuccessCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:I

    .line 37
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "imageFailedCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:I

    .line 38
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "imageCanceledCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:I

    .line 39
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "network"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:I

    .line 40
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "networkOnRequest"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:I

    .line 41
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "networkSuccessCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->i:I

    .line 42
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "networkFailedCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->j:I

    .line 43
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    const-string v3, "networkCanceledCount"

    invoke-interface {v1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 45
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v3, 0x0

    .line 46
    aget-wide v4, v1, v3

    iget-object v6, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:[J

    aget-wide v7, v6, v3

    sub-long/2addr v4, v7

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v4

    const-string v5, "totalRx"

    invoke-interface {v2, v5, v4}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 47
    aget-wide v4, v1, v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:[J

    aget-wide v0, v1, v0

    sub-long/2addr v4, v0

    invoke-static {v4, v5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "totalTx"

    invoke-interface {v2, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 49
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v4, "procedureEndTime"

    invoke-interface {v0, v4, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 50
    sput-boolean v3, Lcom/taobao/monitor/impl/data/GlobalStats;->hasSplash:Z

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 52
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 53
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 54
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 55
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 56
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 57
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 58
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 59
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    .line 60
    sget-object v0, Lcom/taobao/monitor/impl/trace/j;->a:Lcom/taobao/monitor/impl/trace/j;

    invoke-virtual {v0, p0}, Lcom/taobao/monitor/impl/trace/a;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 61
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 63
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->c()V

    :cond_1
    return-void
.end method

.method public c(I)V
    .locals 2

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:I

    :cond_3
    :goto_0
    return-void
.end method

.method public c(Landroid/app/Activity;J)V
    .locals 2

    .line 8
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 9
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 10
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "pageName"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPostStopped"

    .line 11
    invoke-interface {p2, p3, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_0

    .line 14
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->c()V

    :cond_0
    return-void
.end method

.method public c(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 1

    iput-wide p3, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:J

    .line 3
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->b()V

    .line 4
    new-instance p2, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p2, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 5
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p2, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 6
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p3, "pageName"

    invoke-virtual {p2, p3, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPreCreated"

    .line 7
    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public d(I)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/util/List;

    .line 29
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0xc8

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->b:Ljava/util/List;

    .line 30
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public d(Landroid/app/Activity;J)V
    .locals 4

    .line 18
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 19
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 20
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string v1, "pageName"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostResumed"

    .line 21
    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:J

    sub-long v0, p2, v0

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:J

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->h:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 25
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "resumedDuration"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "resumedTime"

    .line 28
    invoke-interface {p1, v0, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public e(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "pageName"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityStopped"

    .line 4
    invoke-interface {p2, p3, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_0

    .line 5
    sget-boolean p1, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez p1, :cond_0

    .line 6
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->c()V

    :cond_0
    return-void
.end method

.method public f(Landroid/app/Activity;J)V
    .locals 4

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string v1, "pageName"

    invoke-virtual {v0, v1, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostStarted"

    .line 4
    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->e:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:J

    sub-long/2addr p2, v0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:J

    add-long/2addr p2, v0

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->g:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 8
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "startedDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public g(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityStarted"

    .line 4
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public h(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPreDestroyed"

    .line 4
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public i(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p2

    const-string p3, "pageName"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityDestroyed"

    .line 4
    invoke-interface {p2, p3, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_0

    .line 5
    sget-boolean p1, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez p1, :cond_0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->f:Z

    .line 7
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/launcher/b;->c()V

    :cond_0
    return-void
.end method

.method public j(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPaused"

    .line 4
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public k(Landroid/app/Activity;J)V
    .locals 2

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->d:J

    .line 3
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 4
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 5
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPreResumed"

    .line 6
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public l(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPreStopped"

    .line 4
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public m(Landroid/app/Activity;J)V
    .locals 2

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->c:J

    .line 3
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 4
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 5
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPreStarted"

    .line 6
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public n(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPostPaused"

    .line 4
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public o(Landroid/app/Activity;J)V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x2

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 3
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "pageName"

    invoke-virtual {v0, p2, p1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "onActivityPrePaused"

    .line 4
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public onLowMemory()V
    .locals 3

    .line 1
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/launcher/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onLowMemory"

    .line 3
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
