.class public Lcom/taobao/monitor/impl/processor/b/b;
.super Lcom/taobao/monitor/impl/processor/a;
.source "WeexProcessor.java"

# interfaces
.implements Lcom/taobao/monitor/performance/IWXApmAdapter;
.implements Lcom/taobao/monitor/impl/trace/i$c;
.implements Lcom/taobao/monitor/impl/trace/e$b;
.implements Lcom/taobao/monitor/impl/trace/f$b;
.implements Lcom/taobao/monitor/impl/trace/d$b;
.implements Lcom/taobao/monitor/impl/trace/m$b;
.implements Lcom/taobao/monitor/impl/trace/n$b;
.implements Lcom/taobao/monitor/impl/data/h;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/processor/a;",
        "Lcom/taobao/monitor/performance/IWXApmAdapter;",
        "Lcom/taobao/monitor/impl/trace/i$c;",
        "Lcom/taobao/monitor/impl/trace/e$b;",
        "Lcom/taobao/monitor/impl/trace/f$b;",
        "Lcom/taobao/monitor/impl/trace/d$b;",
        "Lcom/taobao/monitor/impl/trace/m$b;",
        "Lcom/taobao/monitor/impl/trace/n$b;",
        "Lcom/taobao/monitor/impl/data/h<",
        "Landroid/app/Activity;",
        ">;"
    }
.end annotation


# instance fields
.field private a:I

.field private a:J

.field private a:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private a:Lcom/taobao/monitor/procedure/IProcedure;

.field private final a:Ljava/lang/String;

.field private a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private b:I

.field private b:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private b:Z

.field private c:I

.field private c:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private c:Z

.field private d:I

.field private d:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private d:Z

.field private e:I

.field private e:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private e:Z

.field private f:I

.field private f:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private f:Z

.field private g:I

.field private h:I

.field private i:I

.field private j:I


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    .line 1
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/a;-><init>(Z)V

    .line 2
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Ljava/util/List;

    iput v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:I

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:Z

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:I

    return-void
.end method

.method public a(I)V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:I

    :cond_0
    return-void
.end method

.method public a(IJ)V
    .locals 2

    const-string v0, "timestamp"

    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    .line 8
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 9
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "foreground2Background"

    .line 10
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 12
    invoke-static {}, Lcom/taobao/monitor/impl/common/Global;->instance()Lcom/taobao/monitor/impl/common/Global;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/monitor/impl/common/Global;->handler()Landroid/os/Handler;

    move-result-object p1

    new-instance p2, Lcom/taobao/monitor/impl/processor/b/b$a;

    invoke-direct {p2, p0}, Lcom/taobao/monitor/impl/processor/b/b$a;-><init>(Lcom/taobao/monitor/impl/processor/b/b;)V

    invoke-virtual {p1, p2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0

    .line 20
    :cond_0
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 21
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "background2Foreground"

    .line 22
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :goto_0
    return-void
.end method

.method public a(Landroid/app/Activity;FJ)V
    .locals 1

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 51
    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p2

    const-string v0, "onRenderPercent"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 52
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "drawPercentTime"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;IIJ)V
    .locals 2

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:Z

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz p1, :cond_1

    const/4 p1, 0x2

    if-ne p2, p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:J

    sub-long v0, p4, v0

    .line 40
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "interactiveDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:J

    sub-long v0, p4, v0

    .line 41
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "loadDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 42
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const-string p3, "usableChangeType"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "interactiveTime"

    .line 43
    invoke-interface {p1, p2, p4, p5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:Z

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;IJ)V
    .locals 2

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:Z

    if-nez p1, :cond_0

    return-void

    :cond_0
    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz p1, :cond_1

    const/4 p1, 0x2

    if-ne p2, p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:J

    sub-long v0, p3, v0

    .line 29
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "displayDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "displayedTime"

    .line 30
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:Z

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;JJ)V
    .locals 0

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:Z

    if-eqz p1, :cond_0

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide p4, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:J

    sub-long p4, p2, p4

    .line 47
    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "pageInitDuration"

    invoke-interface {p1, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p4, "renderStartTime"

    .line 48
    invoke-interface {p1, p4, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:Z

    :cond_0
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;FJ)V
    .locals 0

    .line 1
    check-cast p1, Landroid/app/Activity;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/b/b;->a(Landroid/app/Activity;FJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IIJ)V
    .locals 0

    .line 3
    check-cast p1, Landroid/app/Activity;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/b/b;->a(Landroid/app/Activity;IIJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IJ)V
    .locals 0

    .line 4
    check-cast p1, Landroid/app/Activity;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/b/b;->a(Landroid/app/Activity;IJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;JJ)V
    .locals 0

    .line 2
    check-cast p1, Landroid/app/Activity;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/b/b;->a(Landroid/app/Activity;JJ)V

    return-void
.end method

.method public addBiz(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addBiz(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public addBizAbTest(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addBizAbTest(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public addBizStage(Ljava/lang/String;Ljava/util/Map;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;)V"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addBizStage(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public addProperty(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public addStatistic(Ljava/lang/String;D)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-static {p2, p3}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method protected b()V
    .locals 4

    .line 1
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->b()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:J

    .line 3
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    invoke-direct {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;-><init>()V

    const/4 v1, 0x1

    .line 4
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 5
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 6
    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureManagerProxy;

    .line 7
    invoke-virtual {v1}, Lcom/taobao/monitor/procedure/ProcedureManagerProxy;->getCurrentActivityProcedure()Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 8
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 10
    sget-object v1, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "/"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v3, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/taobao/monitor/impl/util/TopicUtils;->getFullTopic(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 11
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 13
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "ACTIVITY_EVENT_DISPATCHER"

    .line 15
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_LOW_MEMORY_DISPATCHER"

    .line 16
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_FPS_DISPATCHER"

    .line 17
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_GC_DISPATCHER"

    .line 18
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 19
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_USABLE_VISIBLE_DISPATCHER"

    .line 20
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 22
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 23
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 24
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 25
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 26
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 27
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    return-void
.end method

.method public b(I)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->g:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->g:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->h:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->h:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->i:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->i:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->j:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->j:I

    :cond_3
    :goto_0
    return-void
.end method

.method protected c()V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:I

    .line 3
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "gcCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Ljava/util/List;

    .line 4
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "fps"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:I

    .line 5
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "jankCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:I

    .line 7
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imgLoadCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:I

    .line 8
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imgLoadSuccessCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:I

    .line 9
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imgLoadFailCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:I

    .line 10
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imgLoadCancelCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->g:I

    .line 11
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkRequestCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->h:I

    .line 12
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkRequestSuccessCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->i:I

    .line 13
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkRequestFailCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->j:I

    .line 14
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkRequestCancelCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 16
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 17
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 18
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 19
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 20
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 21
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 22
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 24
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->c()V

    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:Z

    return-void
.end method

.method public c(I)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->c:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->d:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->e:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/b/b;->f:I

    :cond_3
    :goto_0
    return-void
.end method

.method public d(I)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Ljava/util/List;

    .line 1
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0xc8

    if-ge v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Ljava/util/List;

    .line 2
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public onEnd()V
    .locals 0

    .line 1
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/b/b;->c()V

    return-void
.end method

.method public onEvent(Ljava/lang/String;Ljava/lang/Object;)V
    .locals 1

    .line 1
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    .line 2
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 3
    invoke-interface {p2, p1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

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

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onLowMemory"

    .line 3
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public onStage(Ljava/lang/String;J)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public onStart()V
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 2

    .line 1
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/b/b;->b()V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "instanceId"

    .line 2
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public onStop()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/b/b;->b:Z

    return-void
.end method
