.class Lcom/taobao/monitor/impl/processor/fragmentload/b;
.super Lcom/taobao/monitor/impl/processor/a;
.source "FragmentPopProcessor.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/fragmentload/a$b;
.implements Lcom/taobao/monitor/impl/trace/f$b;
.implements Lcom/taobao/monitor/impl/trace/i$c;
.implements Lcom/taobao/monitor/impl/trace/e$b;
.implements Lcom/taobao/monitor/impl/trace/b$c;


# instance fields
.field private a:I

.field private a:J

.field private a:Landroidx/fragment/app/Fragment;

.field private a:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private a:Lcom/taobao/monitor/procedure/IProcedure;

.field private a:Ljava/lang/String;

.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private a:[J

.field private b:I

.field private b:J

.field private b:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private b:Z

.field private c:J

.field private c:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private d:Lcom/taobao/monitor/impl/trace/IDispatcher;


# direct methods
.method public constructor <init>()V
    .locals 3

    const/4 v0, 0x0

    .line 1
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/a;-><init>(Z)V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Landroidx/fragment/app/Fragment;

    const-wide/16 v1, -0x1

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:J

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:J

    const/4 v1, 0x2

    new-array v1, v1, [J

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:[J

    .line 15
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Ljava/util/List;

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:Z

    return-void
.end method

.method private c(Landroidx/fragment/app/Fragment;)V
    .locals 3

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "pageName"

    .line 2
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 3
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "fullPageName"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 5
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 7
    invoke-virtual {p1}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 9
    invoke-virtual {v0}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v0

    .line 10
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "schemaUrl"

    .line 11
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 17
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const-string v2, "isInterpretiveExecution"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 19
    sget-boolean v1, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "isFirstLaunch"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 20
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/taobao/monitor/impl/data/GlobalStats$a;->a(Ljava/lang/String;)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    const-string v1, "isFirstLoad"

    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 21
    sget-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->jumpTime:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "jumpTime"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 23
    sget-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "lastValidTime"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 25
    sget-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    const-string v1, "lastValidPage"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "loadType"

    const-string v1, "pop"

    .line 27
    invoke-interface {p1, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method private d()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v1, 0x1

    .line 2
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errorCode"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 3
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->installType:Ljava/lang/String;

    const-string v2, "installType"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:I

    return-void
.end method

.method public a(I)V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:I

    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V
    .locals 1

    .line 27
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result p1

    if-nez p1, :cond_1

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/4 v0, 0x4

    if-eq p1, v0, :cond_0

    .line 28
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p1

    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    .line 30
    :cond_0
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 31
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p1, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 32
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const-string p3, "key"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "keyEvent"

    .line 33
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/MotionEvent;J)V
    .locals 2

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Landroidx/fragment/app/Fragment;

    if-nez p2, :cond_0

    return-void

    .line 19
    :cond_0
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object p2

    if-ne p1, p2, :cond_1

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "firstInteractiveTime"

    .line 22
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    sub-long/2addr p3, v0

    .line 23
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "firstInteractiveDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:Z

    :cond_1
    return-void
.end method

.method public a(Landroidx/fragment/app/Fragment;)V
    .locals 7

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:J

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:J

    sub-long/2addr v2, v4

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:J

    .line 3
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 4
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {p1, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onFragmentStopped"

    .line 5
    invoke-interface {v1, v2, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 7
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:[J

    const/4 v2, 0x0

    .line 8
    aget-wide v3, p1, v2

    aget-wide v5, v1, v2

    sub-long/2addr v3, v5

    aput-wide v3, v1, v2

    .line 9
    aget-wide v3, p1, v0

    aget-wide v5, v1, v0

    sub-long/2addr v3, v5

    aput-wide v3, v1, v0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:J

    .line 11
    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v3, "totalVisibleDuration"

    invoke-interface {p1, v3, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 13
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v3, "errorCode"

    invoke-interface {p1, v3, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:[J

    .line 14
    aget-wide v2, v1, v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "totalRx"

    invoke-interface {p1, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:[J

    .line 15
    aget-wide v0, v1, v0

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "totalTx"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 17
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c()V

    return-void
.end method

.method protected b()V
    .locals 3

    .line 1
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->b()V

    .line 2
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v1, 0x0

    .line 3
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v2, 0x1

    .line 4
    invoke-virtual {v0, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 5
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v1, 0x0

    .line 6
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 7
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 9
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    const-string v2, "/pageLoad"

    invoke-static {v2}, Lcom/taobao/monitor/impl/util/TopicUtils;->getFullTopic(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 10
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "ACTIVITY_EVENT_DISPATCHER"

    .line 12
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_LOW_MEMORY_DISPATCHER"

    .line 13
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_FPS_DISPATCHER"

    .line 14
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_GC_DISPATCHER"

    .line 15
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 17
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 18
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 19
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 20
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    .line 22
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/b;->d()V

    return-void
.end method

.method public b(Landroidx/fragment/app/Fragment;)V
    .locals 5

    .line 23
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b()V

    .line 24
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c(Landroidx/fragment/app/Fragment;)V

    .line 25
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:J

    .line 29
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 30
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {p1, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onFragmentStarted"

    .line 31
    invoke-interface {v1, v2, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 33
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:[J

    const/4 v2, 0x0

    .line 34
    aget-wide v3, p1, v2

    aput-wide v3, v1, v2

    .line 35
    aget-wide v2, p1, v0

    aput-wide v2, v1, v0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    const-string v2, "loadStartTime"

    .line 37
    invoke-interface {p1, v2, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 40
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    sub-long v2, v0, v2

    .line 41
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "pageInitDuration"

    invoke-interface {p1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "renderStartTime"

    .line 42
    invoke-interface {p1, v2, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 46
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    sub-long v2, v0, v2

    .line 47
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "interactiveDuration"

    invoke-interface {p1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    sub-long v2, v0, v2

    .line 48
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "loadDuration"

    invoke-interface {p1, v3, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "interactiveTime"

    .line 50
    invoke-interface {p1, v2, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 52
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    sub-long/2addr v0, v2

    .line 53
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "displayDuration"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:J

    const-string v2, "displayedTime"

    .line 54
    invoke-interface {p1, v2, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method protected c()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 28
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:I

    .line 29
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "gcCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Ljava/util/List;

    .line 30
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "fps"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:I

    .line 31
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "jankCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 32
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 33
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 34
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 35
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 36
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 37
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->c()V

    return-void
.end method

.method public d(I)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Ljava/util/List;

    .line 4
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0x3c

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Ljava/util/List;

    .line 5
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
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

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onLowMemory"

    .line 3
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
