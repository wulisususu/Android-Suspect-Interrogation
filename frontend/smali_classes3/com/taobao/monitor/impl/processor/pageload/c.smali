.class public Lcom/taobao/monitor/impl/processor/pageload/c;
.super Lcom/taobao/monitor/impl/processor/a;
.source "PageLoadProcessor.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/pageload/e$a;
.implements Lcom/taobao/monitor/impl/trace/f$b;
.implements Lcom/taobao/monitor/impl/data/h;
.implements Lcom/taobao/monitor/impl/trace/k;
.implements Lcom/taobao/monitor/impl/trace/i$c;
.implements Lcom/taobao/monitor/impl/trace/e$b;
.implements Lcom/taobao/monitor/impl/trace/d$b;
.implements Lcom/taobao/monitor/impl/trace/b$c;
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
        "Lcom/taobao/monitor/impl/trace/k;",
        "Lcom/taobao/monitor/impl/trace/i$c;",
        "Lcom/taobao/monitor/impl/trace/e$b;",
        "Lcom/taobao/monitor/impl/trace/d$b;",
        "Lcom/taobao/monitor/impl/trace/b$c;",
        "Lcom/taobao/monitor/impl/trace/m$b;",
        "Lcom/taobao/monitor/impl/trace/n$b;"
    }
.end annotation


# static fields
.field private static a:Ljava/lang/String; = ""

.field private static a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private a:I

.field private a:J

.field private a:Landroid/app/Activity;

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

.field private b:Z

.field private b:[J

.field private c:I

.field private c:J

.field private c:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private c:Z

.field private d:I

.field private d:J

.field private d:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private d:Z

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

.field private i:J

.field private j:I

.field private j:J

.field private k:I

.field private k:J

.field private l:J

.field private m:J

.field private n:J


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    const/4 v1, 0x4

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    sput-object v0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/List;

    return-void
.end method

.method public constructor <init>()V
    .locals 5

    const/4 v0, 0x0

    .line 1
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/a;-><init>(Z)V

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->i:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->j:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->l:J

    const/4 v3, 0x0

    iput-object v3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    const-wide/16 v3, -0x1

    iput-wide v3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->m:J

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->n:J

    const/4 v1, 0x2

    new-array v1, v1, [J

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Z

    .line 35
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:I

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    .line 55
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    iput-object v2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/HashMap;

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:Z

    return-void
.end method

.method private a(Landroid/app/Activity;)V
    .locals 3

    .line 10
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->b(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    sget-object v0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/List;

    .line 11
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0xa

    if-ge v0, v1, :cond_0

    sget-object v0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/List;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    .line 12
    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    const-string v2, "pageName"

    .line 14
    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 15
    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "fullPageName"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    sget-object v0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/lang/String;

    .line 16
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    sget-object v1, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/lang/String;

    const-string v2, "fromPageName"

    .line 17
    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 19
    :cond_1
    invoke-virtual {p1}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 21
    invoke-virtual {v0}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v0

    .line 22
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_2

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "schemaUrl"

    .line 23
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_2
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 27
    sget-boolean v1, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "isFirstLaunch"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 28
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/taobao/monitor/impl/data/GlobalStats$a;->a(Ljava/lang/String;)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    const-string v1, "isFirstLoad"

    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 29
    sget-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->jumpTime:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "jumpTime"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const-wide/16 v0, -0x1

    .line 30
    sput-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->jumpTime:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 32
    sget-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "lastValidTime"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    sget-object v0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/List;

    .line 33
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "lastValidLinksPage"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 34
    sget-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    const-string v1, "lastValidPage"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "loadType"

    const-string v1, "push"

    .line 37
    invoke-interface {p1, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method private d()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v1, 0x1

    .line 2
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errorCode"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 3
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->installType:Ljava/lang/String;

    const-string v2, "installType"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "leaveType"

    const-string v2, "other"

    .line 4
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:I

    :cond_0
    return-void
.end method

.method public a(I)V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:I

    :cond_0
    return-void
.end method

.method public a(IJ)V
    .locals 2

    const-string v0, "timestamp"

    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    .line 114
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 115
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "foreground2Background"

    .line 116
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 117
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/pageload/c;->c()V

    goto :goto_0

    .line 119
    :cond_0
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 120
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "background2Foreground"

    .line 121
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :goto_0
    return-void
.end method

.method public a(Landroid/app/Activity;FJ)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 68
    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p2

    const-string v0, "onRenderPercent"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 69
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "drawPercentTime"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;IIJ)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_2

    const/4 v0, 0x2

    if-ne p2, v0, :cond_2

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    sub-long v0, p4, v0

    .line 78
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "interactiveDuration"

    invoke-interface {p2, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    sub-long v0, p4, v0

    .line 79
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "loadDuration"

    invoke-interface {p2, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 80
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const-string v0, "usableChangeType"

    invoke-interface {p2, v0, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "interactiveTime"

    .line 82
    invoke-interface {p2, p3, p4, p5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p3, 0x0

    .line 85
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    const-string p5, "errorCode"

    invoke-interface {p2, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    .line 86
    aget-wide v0, p4, p3

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "totalRx"

    invoke-interface {p2, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    const/4 p5, 0x1

    .line 87
    aget-wide v0, p4, p5

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "totalTx"

    invoke-interface {p2, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-boolean p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:Z

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    if-eqz p2, :cond_2

    .line 92
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-eqz p2, :cond_2

    .line 93
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    .line 94
    invoke-interface {p4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p4

    :goto_0
    invoke-interface {p4}, Ljava/util/Iterator;->hasNext()Z

    move-result p5

    if-eqz p5, :cond_1

    invoke-interface {p4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Ljava/lang/Integer;

    .line 95
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    invoke-virtual {p5}, Ljava/lang/Integer;->intValue()I

    move-result p5

    add-int/2addr p2, p5

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    goto :goto_0

    .line 97
    :cond_1
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result p4

    div-int/2addr p2, p4

    int-to-float p2, p2

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    .line 98
    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result p4

    iput p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:I

    .line 99
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object p4

    invoke-virtual {p4}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IPageFpsListener;

    move-result-object p4

    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object p5

    invoke-interface {p4, p5, p1, p3, p2}, Lcom/taobao/application/common/IPageFpsListener;->onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V

    :cond_2
    return-void
.end method

.method public a(Landroid/app/Activity;IJ)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_1

    const/4 p1, 0x2

    if-ne p2, p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    sub-long v0, p3, v0

    .line 106
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "displayDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "displayedTime"

    .line 107
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:Z

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;J)V
    .locals 2

    .line 38
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 39
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostDestroyed"

    .line 40
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:J

    sub-long/2addr p2, v0

    .line 42
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "destroyedDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 44
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/pageload/c;->c()V

    return-void
.end method

.method public a(Landroid/app/Activity;JJ)V
    .locals 0

    iget-boolean p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:Z

    if-eqz p4, :cond_0

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-ne p1, p4, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide p4, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    sub-long p4, p2, p4

    .line 64
    invoke-static {p4, p5}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "pageInitDuration"

    invoke-interface {p1, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p4, "renderStartTime"

    .line 65
    invoke-interface {p1, p4, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:Z

    :cond_0
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 2

    .line 5
    new-instance p1, Ljava/util/HashMap;

    const/4 p2, 0x1

    invoke-direct {p1, p2}, Ljava/util/HashMap;-><init>(I)V

    .line 6
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "timestamp"

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "onActivityPostCreated"

    .line 7
    invoke-interface {p2, v0, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:J

    sub-long/2addr p3, v0

    .line 9
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "createdDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-ne p1, v0, :cond_2

    .line 123
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result p1

    .line 124
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    if-nez p1, :cond_2

    const/4 p1, 0x4

    const/4 v1, 0x3

    if-eq v0, p1, :cond_0

    if-ne v0, v1, :cond_2

    :cond_0
    const-string p1, "leaveType"

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "home"

    .line 130
    invoke-interface {v0, p1, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_0

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "back"

    .line 132
    invoke-interface {v0, p1, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 135
    :goto_0
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 136
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p1, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 137
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const-string p3, "key"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "keyEvent"

    .line 138
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_2
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/MotionEvent;J)V
    .locals 2

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-ne p1, p2, :cond_1

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:Z

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "firstInteractiveTime"

    .line 49
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    sub-long v0, p3, v0

    .line 50
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "firstInteractiveDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "leaveType"

    const-string v0, "touch"

    .line 51
    invoke-interface {p1, p2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:Z

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 53
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    const-string v0, "errorCode"

    invoke-interface {p2, v0, p1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    sget-object p1, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/List;

    .line 58
    invoke-interface {p1}, Ljava/util/List;->clear()V

    sget-object p1, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/List;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    .line 59
    invoke-interface {p1, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    .line 60
    sput-object p1, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    .line 61
    sput-wide p3, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    :cond_1
    return-void
.end method

.method public a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V
    .locals 1

    if-nez p2, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    if-eq p1, v0, :cond_1

    return-void

    .line 141
    :cond_1
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p1

    .line 142
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

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/HashMap;

    .line 144
    invoke-virtual {p2, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Ljava/lang/Integer;

    if-nez p2, :cond_2

    const/4 p2, 0x0

    .line 146
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    goto :goto_0

    .line 148
    :cond_2
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    add-int/lit8 p2, p2, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    :goto_0
    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/util/HashMap;

    .line 150
    invoke-virtual {p3, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 151
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

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/pageload/c;->a(Landroid/app/Activity;FJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IIJ)V
    .locals 0

    .line 3
    check-cast p1, Landroid/app/Activity;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/pageload/c;->a(Landroid/app/Activity;IIJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IJ)V
    .locals 0

    .line 4
    check-cast p1, Landroid/app/Activity;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/pageload/c;->a(Landroid/app/Activity;IJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;JJ)V
    .locals 0

    .line 2
    check-cast p1, Landroid/app/Activity;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/pageload/c;->a(Landroid/app/Activity;JJ)V

    return-void
.end method

.method protected b()V
    .locals 5

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
    invoke-virtual {v0, v2}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    const/4 v3, 0x0

    .line 6
    invoke-virtual {v0, v3}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;

    move-result-object v0

    .line 7
    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->build()Lcom/taobao/monitor/procedure/ProcedureConfig;

    move-result-object v0

    .line 9
    sget-object v3, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->PROXY:Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;

    const-string v4, "/pageLoad"

    invoke-static {v4}, Lcom/taobao/monitor/impl/util/TopicUtils;->getFullTopic(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4, v0}, Lcom/taobao/monitor/procedure/ProcedureFactoryProxy;->createProcedure(Ljava/lang/String;Lcom/taobao/monitor/procedure/ProcedureConfig;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 10
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "ACTIVITY_EVENT_DISPATCHER"

    .line 12
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_LOW_MEMORY_DISPATCHER"

    .line 13
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_USABLE_VISIBLE_DISPATCHER"

    .line 14
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_FPS_DISPATCHER"

    .line 15
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_GC_DISPATCHER"

    .line 16
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 17
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "NETWORK_STAGE_DISPATCHER"

    .line 18
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "IMAGE_STAGE_DISPATCHER"

    .line 19
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 21
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 22
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 23
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 24
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 25
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 26
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 27
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 28
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    .line 29
    sget-object v0, Lcom/taobao/monitor/impl/trace/j;->a:Lcom/taobao/monitor/impl/trace/j;

    invoke-virtual {v0, p0}, Lcom/taobao/monitor/impl/trace/a;->addListener(Ljava/lang/Object;)V

    .line 31
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/pageload/c;->d()V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    const-wide/16 v3, 0x0

    .line 32
    aput-wide v3, v0, v1

    .line 33
    aput-wide v3, v0, v2

    return-void
.end method

.method public b(I)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->i:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->i:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->j:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->j:I

    :cond_3
    :goto_0
    return-void
.end method

.method public b(Landroid/app/Activity;J)V
    .locals 4

    .line 50
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {p1, v0}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 51
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 52
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityResumed"

    .line 53
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 55
    sget-boolean p1, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "resumedTime"

    .line 57
    invoke-interface {p1, v0, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public b(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 1

    iput-wide p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    if-nez p2, :cond_0

    .line 36
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/pageload/c;->b()V

    :cond_0
    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    const-string v0, "loadStartTime"

    .line 38
    invoke-interface {p2, v0, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 40
    new-instance p2, Ljava/util/HashMap;

    const/4 p3, 0x1

    invoke-direct {p2, p3}, Ljava/util/HashMap;-><init>(I)V

    iget-wide p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:J

    .line 41
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p2, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p4, "onActivityCreated"

    .line 42
    invoke-interface {p3, p4, p2}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Landroid/app/Activity;

    .line 45
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object p2

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {p2, p3}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 47
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/processor/pageload/c;->a(Landroid/app/Activity;)V

    .line 49
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:[J

    return-void
.end method

.method protected c()V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:Z

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->n:J

    .line 15
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "totalVisibleDuration"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 16
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "deviceLevel"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 17
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getOutlineInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->runtimeLevel:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "runtimeLevel"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 18
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfDevcie:F

    invoke-static {v1}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object v1

    const-string v2, "cpuUsageOfDevcie"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 19
    invoke-static {}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getInstance()Lcom/ali/alihadeviceevaluator/AliHAHardware;

    move-result-object v1

    invoke-virtual {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getMemoryInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "memoryRuntimeLevel"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 21
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:I

    .line 22
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "gcCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    .line 23
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "fps"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:I

    .line 24
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "jankCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:I

    .line 26
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "image"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:I

    .line 27
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageOnRequest"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:I

    .line 28
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageSuccessCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:I

    .line 29
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageFailedCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:I

    .line 30
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageCanceledCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:I

    .line 31
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "network"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:I

    .line 32
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkOnRequest"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:I

    .line 33
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkSuccessCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->i:I

    .line 34
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkFailedCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->j:I

    .line 35
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkCanceledCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 37
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 38
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 39
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 40
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 41
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 42
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 43
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 44
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    .line 45
    sget-object v0, Lcom/taobao/monitor/impl/trace/j;->a:Lcom/taobao/monitor/impl/trace/j;

    invoke-virtual {v0, p0}, Lcom/taobao/monitor/impl/trace/a;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 46
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 48
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->c()V

    :cond_0
    return-void
.end method

.method public c(I)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:I

    :cond_3
    :goto_0
    return-void
.end method

.method public c(Landroid/app/Activity;J)V
    .locals 4

    .line 6
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 7
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostStopped"

    .line 8
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->l:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:J

    sub-long/2addr p2, v0

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->l:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 12
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "stoppedDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public c(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 0

    iput-wide p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:J

    .line 2
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/pageload/c;->b()V

    .line 3
    new-instance p1, Ljava/util/HashMap;

    const/4 p2, 0x1

    invoke-direct {p1, p2}, Ljava/util/HashMap;-><init>(I)V

    .line 4
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPreCreated"

    .line 5
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public d(I)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    .line 17
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0xc8

    if-ge v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    .line 18
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public d(Landroid/app/Activity;J)V
    .locals 4

    .line 5
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 6
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostResumed"

    .line 7
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->j:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:J

    sub-long v0, p2, v0

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->j:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 11
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "resumedDuration"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:J

    cmp-long p1, v0, v2

    if-nez p1, :cond_1

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->e:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "resumedTime"

    .line 16
    invoke-interface {p1, v0, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_1
    return-void
.end method

.method public e(Landroid/app/Activity;J)V
    .locals 9

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->n:J

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->m:J

    sub-long v2, p2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->n:J

    .line 3
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 4
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v0, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityStopped"

    .line 5
    invoke-interface {p2, p3, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 7
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p2

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    const/4 v0, 0x0

    .line 8
    aget-wide v2, p3, v0

    aget-wide v4, p2, v0

    iget-object v6, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:[J

    aget-wide v7, v6, v0

    sub-long/2addr v4, v7

    add-long/2addr v2, v4

    aput-wide v2, p3, v0

    .line 9
    aget-wide v2, p3, v1

    aget-wide v4, p2, v1

    aget-wide v7, v6, v1

    sub-long/2addr v4, v7

    add-long/2addr v2, v4

    aput-wide v2, p3, v1

    iput-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:[J

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    if-eqz p2, :cond_1

    iget p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:I

    .line 14
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-ge p3, p2, :cond_1

    .line 15
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    iget p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:I

    :goto_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    .line 16
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p3, v0, :cond_0

    .line 17
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    invoke-interface {v0, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    add-int/2addr p2, v0

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    add-int/lit8 p3, p3, 0x1

    goto :goto_0

    .line 19
    :cond_0
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/util/List;

    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result p3

    iget v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:I

    sub-int/2addr p3, v0

    div-int/2addr p2, p3

    int-to-float p2, p2

    .line 20
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object p3

    invoke-virtual {p3}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IPageFpsListener;

    move-result-object p3

    invoke-static {p1}, Lcom/taobao/monitor/impl/util/a;->a(Landroid/app/Activity;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p3, v0, p1, v1, p2}, Lcom/taobao/application/common/IPageFpsListener;->onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V

    :cond_1
    return-void
.end method

.method public f(Landroid/app/Activity;J)V
    .locals 4

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostStarted"

    .line 3
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->i:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:J

    sub-long/2addr p2, v0

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->i:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 7
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "startedDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public g(Landroid/app/Activity;J)V
    .locals 10

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->m:J

    .line 4
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p1}, Ljava/util/HashMap;-><init>(I)V

    .line 5
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onActivityStarted"

    .line 6
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 9
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentActivityProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    sput-object v0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Ljava/lang/String;

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Z

    .line 14
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    .line 15
    aget-wide v3, v2, v0

    aget-wide v5, v1, v0

    iget-object v7, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:[J

    aget-wide v8, v7, v0

    sub-long/2addr v5, v8

    add-long/2addr v3, v5

    aput-wide v3, v2, v0

    .line 16
    aget-wide v3, v2, p1

    aget-wide v0, v1, p1

    aget-wide v5, v7, p1

    sub-long/2addr v0, v5

    add-long/2addr v3, v0

    aput-wide v3, v2, p1

    .line 19
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:[J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:Ljava/lang/String;

    .line 20
    sput-object p1, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    .line 21
    sput-wide p2, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    return-void
.end method

.method public h(Landroid/app/Activity;J)V
    .locals 1

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->h:J

    .line 2
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 3
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPreDestroyed"

    .line 4
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public i(Landroid/app/Activity;J)V
    .locals 8

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityDestroyed"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 5
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->b:[J

    const/4 p3, 0x0

    .line 6
    aget-wide v1, p2, p3

    aget-wide v3, p1, p3

    iget-object v5, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:[J

    aget-wide v6, v5, p3

    sub-long/2addr v3, v6

    add-long/2addr v1, v3

    aput-wide v1, p2, p3

    .line 7
    aget-wide v1, p2, v0

    aget-wide v3, p1, v0

    aget-wide v6, v5, v0

    sub-long/2addr v3, v6

    add-long/2addr v1, v3

    aput-wide v1, p2, v0

    .line 9
    sget-boolean p1, Lcom/taobao/monitor/impl/data/m/b;->a:Z

    if-nez p1, :cond_0

    .line 10
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/pageload/c;->c()V

    :cond_0
    return-void
.end method

.method public j(Landroid/app/Activity;J)V
    .locals 1

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:Z

    .line 2
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 3
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPaused"

    .line 4
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public k(Landroid/app/Activity;J)V
    .locals 1

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->d:J

    .line 2
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 3
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPreResumed"

    .line 4
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public l(Landroid/app/Activity;J)V
    .locals 1

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->g:J

    .line 2
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 3
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPreStopped"

    .line 4
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public m(Landroid/app/Activity;J)V
    .locals 1

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->c:J

    .line 2
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 3
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPreStarted"

    .line 4
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public n(Landroid/app/Activity;J)V
    .locals 4

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onActivityPostPaused"

    .line 3
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:J

    const-wide/16 v2, 0x0

    cmp-long p1, v0, v2

    if-nez p1, :cond_0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:J

    sub-long/2addr p2, v0

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->k:J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 7
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "pausedDuration"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public o(Landroid/app/Activity;J)V
    .locals 1

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->f:J

    .line 2
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 3
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onActivityPrePaused"

    .line 4
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

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

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/pageload/c;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onLowMemory"

    .line 3
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
