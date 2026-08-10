.class Lcom/taobao/monitor/impl/processor/fragmentload/d;
.super Lcom/taobao/monitor/impl/processor/a;
.source "FragmentProcessor.java"

# interfaces
.implements Lcom/taobao/monitor/impl/processor/fragmentload/a$a;
.implements Lcom/taobao/monitor/impl/trace/f$b;
.implements Lcom/taobao/monitor/impl/data/h;
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
        "Lcom/taobao/monitor/impl/processor/fragmentload/a$a;",
        "Lcom/taobao/monitor/impl/trace/f$b;",
        "Lcom/taobao/monitor/impl/data/h<",
        "Landroidx/fragment/app/Fragment;",
        ">;",
        "Lcom/taobao/monitor/impl/trace/i$c;",
        "Lcom/taobao/monitor/impl/trace/e$b;",
        "Lcom/taobao/monitor/impl/trace/d$b;",
        "Lcom/taobao/monitor/impl/trace/b$c;",
        "Lcom/taobao/monitor/impl/trace/m$b;",
        "Lcom/taobao/monitor/impl/trace/n$b;"
    }
.end annotation


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

.field private e:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private e:Z

.field private f:I

.field private f:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private f:Z

.field private g:I

.field private g:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private g:Z

.field private h:I

.field private h:Lcom/taobao/monitor/impl/trace/IDispatcher;

.field private h:Z

.field private i:I

.field private j:I

.field private k:I


# direct methods
.method public constructor <init>()V
    .locals 3

    const/4 v0, 0x0

    .line 1
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/a;-><init>(Z)V

    const/4 v1, 0x0

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    const-wide/16 v1, -0x1

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:J

    const-wide/16 v1, 0x0

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:J

    const/4 v1, 0x2

    new-array v1, v1, [J

    iput-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:Z

    .line 21
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:I

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:I

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:Z

    iput-boolean v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:Z

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:Z

    return-void
.end method

.method private a()Z
    .locals 11

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    .line 74
    invoke-direct {p0, v0}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a(Landroidx/fragment/app/Fragment;)Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    return v1

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 78
    instance-of v2, v0, Lcom/taobao/monitor/procedure/ProcedureProxy;

    const/4 v3, 0x1

    if-eqz v2, :cond_7

    .line 79
    check-cast v0, Lcom/taobao/monitor/procedure/ProcedureProxy;

    invoke-virtual {v0}, Lcom/taobao/monitor/procedure/ProcedureProxy;->events()Ljava/util/List;

    move-result-object v0

    if-eqz v0, :cond_7

    .line 85
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v2

    sub-int/2addr v2, v3

    const/4 v4, -0x1

    move v5, v4

    move v6, v5

    move v7, v6

    :goto_0
    if-ltz v2, :cond_4

    .line 86
    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lcom/taobao/monitor/procedure/model/Event;

    .line 87
    invoke-virtual {v8}, Lcom/taobao/monitor/procedure/model/Event;->name()Ljava/lang/String;

    move-result-object v9

    const-string v10, "onFragmentResumed"

    invoke-static {v9, v10}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_1

    move v5, v2

    goto :goto_1

    .line 89
    :cond_1
    invoke-virtual {v8}, Lcom/taobao/monitor/procedure/model/Event;->name()Ljava/lang/String;

    move-result-object v9

    const-string v10, "background2Foreground"

    invoke-static {v9, v10}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_2

    move v6, v2

    goto :goto_1

    .line 91
    :cond_2
    invoke-virtual {v8}, Lcom/taobao/monitor/procedure/model/Event;->name()Ljava/lang/String;

    move-result-object v8

    const-string v9, "onFragmentStopped"

    invoke-static {v8, v9}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_3

    move v7, v2

    :cond_3
    :goto_1
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    :cond_4
    if-eq v5, v4, :cond_6

    if-ltz v6, :cond_5

    if-lt v6, v5, :cond_6

    :cond_5
    if-ltz v7, :cond_7

    if-ge v7, v5, :cond_7

    :cond_6
    return v1

    :cond_7
    return v3
.end method

.method private a(Landroidx/fragment/app/Fragment;)Z
    .locals 2

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return v0

    .line 71
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v1, "com.gyf.immersionbar.SupportRequestManagerFragment"

    .line 73
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_1

    const-string v1, "com.bumptech.glide.manager.SupportRequestManagerFragment"

    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_1

    goto :goto_0

    :cond_1
    const/4 v0, 0x1

    :goto_0
    return v0
.end method

.method private c(Landroidx/fragment/app/Fragment;)V
    .locals 4

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/lang/String;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "pageName"

    .line 2
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 3
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "fullPageName"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 5
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 7
    invoke-virtual {v0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 9
    invoke-virtual {v1}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v1

    .line 10
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_0

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v3, "schemaUrl"

    .line 11
    invoke-interface {v2, v3, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 14
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const-string v2, "activityName"

    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_1
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 18
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    const-string v2, "isInterpretiveExecution"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 20
    sget-boolean v1, Lcom/taobao/monitor/impl/data/GlobalStats;->isFirstLaunch:Z

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    const-string v2, "isFirstLaunch"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 21
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->activityStatusManager:Lcom/taobao/monitor/impl/data/GlobalStats$a;

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/taobao/monitor/impl/data/GlobalStats$a;->a(Ljava/lang/String;)Z

    move-result p1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    const-string v1, "isFirstLoad"

    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 23
    sget-wide v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "lastValidTime"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 24
    sget-object v0, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    const-string v1, "lastValidPage"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "loadType"

    const-string v1, "push"

    .line 27
    invoke-interface {p1, v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method private d()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureStartTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 v1, 0x1

    .line 2
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "errorCode"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 3
    sget-object v1, Lcom/taobao/monitor/impl/data/GlobalStats;->installType:Ljava/lang/String;

    const-string v2, "installType"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "leaveType"

    const-string v2, "other"

    .line 4
    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:I

    :cond_0
    return-void
.end method

.method public a(I)V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:I

    :cond_0
    return-void
.end method

.method public a(IJ)V
    .locals 2

    const-string v0, "timestamp"

    const/4 v1, 0x1

    if-ne p1, v1, :cond_0

    .line 96
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 97
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "foreground2Background"

    .line 98
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 99
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c()V

    goto :goto_0

    .line 101
    :cond_0
    new-instance p1, Ljava/util/HashMap;

    invoke-direct {p1, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 102
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    invoke-virtual {p1, v0, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "background2Foreground"

    .line 103
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :goto_0
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    if-nez v0, :cond_0

    return-void

    .line 108
    :cond_0
    :try_start_0
    invoke-virtual {v0}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    :goto_0
    if-ne p1, v0, :cond_3

    .line 114
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result p1

    .line 115
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result v0

    if-nez p1, :cond_3

    const/4 p1, 0x4

    const/4 v1, 0x3

    if-eq v0, p1, :cond_1

    if-ne v0, v1, :cond_3

    :cond_1
    const-string p1, "leaveType"

    if-ne v0, v1, :cond_2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "home"

    .line 121
    invoke-interface {v0, p1, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    goto :goto_1

    :cond_2
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "back"

    .line 123
    invoke-interface {v0, p1, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 126
    :goto_1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x2

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 127
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    const-string p4, "timestamp"

    invoke-virtual {p1, p4, p3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getKeyCode()I

    move-result p2

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    const-string p3, "key"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "keyEvent"

    .line 129
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_3
    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/MotionEvent;J)V
    .locals 2

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    if-nez p2, :cond_0

    return-void

    .line 8
    :cond_0
    :try_start_0
    invoke-virtual {p2}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object p2

    if-ne p1, p2, :cond_1

    iget-boolean p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:Z

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "firstInteractiveTime"

    .line 12
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const-string p2, "firstInteractiveDuration"

    :try_start_1
    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:J

    sub-long/2addr p3, v0

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:J

    sub-long/2addr p3, v0

    .line 13
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p3

    invoke-interface {p1, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "leaveType"

    const-string p3, "touch"

    .line 14
    invoke-interface {p1, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    const-string p2, "errorCode"

    const/4 p3, 0x0

    .line 15
    :try_start_2
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    invoke-interface {p1, p2, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-boolean p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:Z
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 20
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    :goto_0
    return-void
.end method

.method public a(Landroidx/fragment/app/Fragment;FJ)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 31
    invoke-static {p2}, Ljava/lang/Float;->valueOf(F)Ljava/lang/Float;

    move-result-object p2

    const-string v0, "onRenderPercent"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 32
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "drawPercentTime"

    invoke-interface {p1, p3, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    return-void
.end method

.method public a(Landroidx/fragment/app/Fragment;IIJ)V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    if-ne p1, v0, :cond_3

    const/4 v0, 0x2

    if-ne p2, v0, :cond_3

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:J

    sub-long v0, p4, v0

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:J

    sub-long/2addr v0, v2

    .line 40
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "interactiveDuration"

    invoke-interface {p2, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:J

    sub-long v0, p4, v0

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:J

    sub-long/2addr v0, v2

    .line 41
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "loadDuration"

    invoke-interface {p2, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 42
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p3

    const-string v0, "usableChangeType"

    invoke-interface {p2, v0, p3}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "interactiveTime"

    .line 44
    invoke-interface {p2, p3, p4, p5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p3, 0x0

    .line 46
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p4

    const-string p5, "errorCode"

    invoke-interface {p2, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    .line 47
    aget-wide v0, p4, p3

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "totalRx"

    invoke-interface {p2, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    const/4 p5, 0x1

    .line 48
    aget-wide v0, p4, p5

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p4

    const-string p5, "totalTx"

    invoke-interface {p2, p5, p4}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-boolean p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:Z

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    if-eqz p2, :cond_3

    .line 53
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-eqz p2, :cond_3

    .line 54
    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    .line 55
    invoke-interface {p4}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p4

    :goto_0
    invoke-interface {p4}, Ljava/util/Iterator;->hasNext()Z

    move-result p5

    if-eqz p5, :cond_1

    invoke-interface {p4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Ljava/lang/Integer;

    .line 56
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    invoke-virtual {p5}, Ljava/lang/Integer;->intValue()I

    move-result p5

    add-int/2addr p2, p5

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    goto :goto_0

    .line 58
    :cond_1
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result p4

    div-int/2addr p2, p4

    int-to-float p2, p2

    iget-object p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    .line 59
    invoke-interface {p4}, Ljava/util/List;->size()I

    move-result p4

    iput p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:I

    .line 60
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object p4

    invoke-virtual {p4}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IPageFpsListener;

    move-result-object p4

    if-nez p1, :cond_2

    const-string p5, ""

    goto :goto_1

    :cond_2
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p5

    invoke-virtual {p5}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p5

    :goto_1
    invoke-interface {p4, p5, p1, p3, p2}, Lcom/taobao/application/common/IPageFpsListener;->onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V

    :cond_3
    return-void
.end method

.method public a(Landroidx/fragment/app/Fragment;IJ)V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:Z

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    if-ne p1, v0, :cond_1

    const/4 p1, 0x2

    if-ne p2, p1, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:J

    sub-long v0, p3, v0

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:J

    sub-long/2addr v0, v2

    .line 67
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string v0, "displayDuration"

    invoke-interface {p1, v0, p2}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "displayedTime"

    .line 68
    invoke-interface {p1, p2, p3, p4}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:Z

    :cond_1
    return-void
.end method

.method public a(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 130
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 131
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentViewDestroyed"

    .line 132
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public a(Landroidx/fragment/app/Fragment;JJ)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:J

    sub-long v0, p2, v0

    .line 23
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "pageInitDuration"

    invoke-interface {p1, v1, v0}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "renderStartTime"

    .line 24
    invoke-interface {p1, v0, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    const-wide/16 p1, 0x0

    cmp-long p1, p4, p1

    if-lez p1, :cond_0

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p2, "waitRenderStartDuration"

    .line 26
    invoke-interface {p1, p2, p4, p5}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    :cond_0
    iput-wide p4, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:J

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:Z

    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;FJ)V
    .locals 0

    .line 1
    check-cast p1, Landroidx/fragment/app/Fragment;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a(Landroidx/fragment/app/Fragment;FJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IIJ)V
    .locals 0

    .line 3
    check-cast p1, Landroidx/fragment/app/Fragment;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a(Landroidx/fragment/app/Fragment;IIJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;IJ)V
    .locals 0

    .line 4
    check-cast p1, Landroidx/fragment/app/Fragment;

    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a(Landroidx/fragment/app/Fragment;IJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;JJ)V
    .locals 0

    .line 2
    check-cast p1, Landroidx/fragment/app/Fragment;

    invoke-virtual/range {p0 .. p5}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a(Landroidx/fragment/app/Fragment;JJ)V

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

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 10
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->begin()Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "ACTIVITY_EVENT_DISPATCHER"

    .line 12
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_LOW_MEMORY_DISPATCHER"

    .line 13
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "FRAGMENT_USABLE_VISIBLE_DISPATCHER"

    .line 14
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "ACTIVITY_FPS_DISPATCHER"

    .line 15
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_GC_DISPATCHER"

    .line 16
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "APPLICATION_BACKGROUND_CHANGED_DISPATCHER"

    .line 17
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "NETWORK_STAGE_DISPATCHER"

    .line 18
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    const-string v0, "IMAGE_STAGE_DISPATCHER"

    .line 19
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/a;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 21
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 22
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 23
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 24
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 25
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 26
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 27
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 28
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    .line 30
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d()V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    const-wide/16 v3, 0x0

    .line 31
    aput-wide v3, v0, v1

    .line 32
    aput-wide v3, v0, v2

    return-void
.end method

.method public b(I)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->i:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->i:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->j:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->j:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->k:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->k:I

    :cond_3
    :goto_0
    return-void
.end method

.method public b(Landroidx/fragment/app/Fragment;J)V
    .locals 2

    .line 33
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {p1, v0}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    .line 34
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 35
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    const-string v1, "timestamp"

    invoke-virtual {p1, v1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "onFragmentResumed"

    .line 36
    invoke-interface {v0, v1, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v0, "resumedTime"

    .line 38
    invoke-interface {p1, v0, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method protected c()V
    .locals 4

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:Z

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:J

    .line 30
    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "totalVisibleDuration"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addProperty(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 31
    invoke-static {}, Lcom/taobao/monitor/impl/util/TimeUtils;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "procedureEndTime"

    invoke-interface {v0, v3, v1, v2}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:I

    .line 32
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "gcCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    .line 33
    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "fps"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:I

    .line 34
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "jankCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:I

    .line 36
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "image"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:I

    .line 37
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageOnRequest"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:I

    .line 38
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageSuccessCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:I

    .line 39
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageFailedCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:I

    .line 40
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "imageCanceledCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:I

    .line 41
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "network"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:I

    .line 42
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkOnRequest"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->i:I

    .line 43
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkSuccessCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->j:I

    .line 44
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkFailedCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    iget v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->k:I

    .line 45
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "networkCanceledCount"

    invoke-interface {v0, v2, v1}, Lcom/taobao/monitor/procedure/IProcedure;->addStatistic(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 47
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 48
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 49
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 50
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 51
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 52
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->h:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 53
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:Lcom/taobao/monitor/impl/trace/IDispatcher;

    .line 54
    invoke-interface {v0, p0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->removeListener(Ljava/lang/Object;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 56
    invoke-direct {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a()Z

    move-result v1

    invoke-interface {v0, v1}, Lcom/taobao/monitor/procedure/IProcedure;->setNeedUpload(Z)Lcom/taobao/monitor/procedure/IProcedure;

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    .line 57
    invoke-interface {v0}, Lcom/taobao/monitor/procedure/IProcedure;->end()Lcom/taobao/monitor/procedure/IProcedure;

    .line 59
    invoke-super {p0}, Lcom/taobao/monitor/impl/processor/a;->c()V

    :cond_0
    return-void
.end method

.method public c(I)V
    .locals 2

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    if-eqz v0, :cond_3

    const/4 v0, 0x1

    if-nez p1, :cond_0

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:I

    goto :goto_0

    :cond_0
    if-ne p1, v0, :cond_1

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->e:I

    goto :goto_0

    :cond_1
    const/4 v1, 0x2

    if-ne p1, v1, :cond_2

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->f:I

    goto :goto_0

    :cond_2
    const/4 v1, 0x3

    if-ne p1, v1, :cond_3

    iget p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:I

    add-int/2addr p1, v0

    iput p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->g:I

    :cond_3
    :goto_0
    return-void
.end method

.method public c(Landroidx/fragment/app/Fragment;J)V
    .locals 9

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    iget-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:J

    iget-wide v3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:J

    sub-long v3, p2, v3

    add-long/2addr v1, v3

    iput-wide v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->d:J

    .line 64
    new-instance v1, Ljava/util/HashMap;

    const/4 v2, 0x1

    invoke-direct {v1, v2}, Ljava/util/HashMap;-><init>(I)V

    .line 65
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {v1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentStopped"

    .line 66
    invoke-interface {p2, p3, v1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 68
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p2

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    .line 69
    aget-wide v3, p3, v0

    aget-wide v5, p2, v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:[J

    aget-wide v7, v1, v0

    sub-long/2addr v5, v7

    add-long/2addr v3, v5

    aput-wide v3, p3, v0

    .line 70
    aget-wide v3, p3, v2

    aget-wide v5, p2, v2

    aget-wide v7, v1, v2

    sub-long/2addr v5, v7

    add-long/2addr v3, v5

    aput-wide v3, p3, v2

    iput-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:[J

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    if-eqz p2, :cond_2

    iget p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:I

    .line 75
    invoke-interface {p2}, Ljava/util/List;->size()I

    move-result p2

    if-ge p3, p2, :cond_2

    .line 76
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    iget p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:I

    :goto_0
    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    .line 77
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-ge p3, v0, :cond_0

    .line 78
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

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

    .line 80
    :cond_0
    invoke-virtual {p2}, Ljava/lang/Integer;->intValue()I

    move-result p2

    iget-object p3, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    invoke-interface {p3}, Ljava/util/List;->size()I

    move-result p3

    iget v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:I

    sub-int/2addr p3, v0

    div-int/2addr p2, p3

    int-to-float p2, p2

    .line 81
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object p3

    invoke-virtual {p3}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/IPageFpsListener;

    move-result-object p3

    if-nez p1, :cond_1

    const-string v0, ""

    goto :goto_1

    :cond_1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v0

    :goto_1
    invoke-interface {p3, v0, p1, v2, p2}, Lcom/taobao/application/common/IPageFpsListener;->onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V

    :cond_2
    return-void
.end method

.method public d(I)V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    .line 5
    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v1, 0xc8

    if-ge v0, v1, :cond_0

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/util/List;

    .line 6
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method

.method public d(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 7
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 8
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentSaveInstanceState"

    .line 9
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public e(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentActivityCreated"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public f(Landroidx/fragment/app/Fragment;J)V
    .locals 10

    .line 1
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {p1, v0}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:Z

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c:J

    .line 5
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0, p1}, Ljava/util/HashMap;-><init>(I)V

    .line 6
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onFragmentStarted"

    .line 7
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:Z

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:Z

    .line 11
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    .line 12
    aget-wide v3, v2, v0

    aget-wide v5, v1, v0

    iget-object v7, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:[J

    aget-wide v8, v7, v0

    sub-long/2addr v5, v8

    add-long/2addr v3, v5

    aput-wide v3, v2, v0

    .line 13
    aget-wide v3, v2, p1

    aget-wide v0, v1, p1

    aget-wide v5, v7, p1

    sub-long/2addr v0, v5

    add-long/2addr v3, v0

    aput-wide v3, v2, p1

    .line 16
    :cond_0
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:[J

    iget-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Ljava/lang/String;

    .line 17
    sput-object p1, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidPage:Ljava/lang/String;

    .line 18
    sput-wide p2, Lcom/taobao/monitor/impl/data/GlobalStats;->lastValidTime:J

    return-void
.end method

.method public g(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentViewCreated"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public h(Landroidx/fragment/app/Fragment;J)V
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

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentDetached"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    .line 5
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b:[J

    const/4 p3, 0x0

    .line 6
    aget-wide v1, p2, p3

    aget-wide v3, p1, p3

    iget-object v5, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:[J

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
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c()V

    return-void
.end method

.method public i(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentCreated"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public j(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentDestroyed"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public k(Landroidx/fragment/app/Fragment;J)V
    .locals 3

    .line 1
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->b()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->instance()Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    invoke-virtual {v0, v1}, Lcom/taobao/monitor/impl/processor/pageload/ProcedureManagerSetter;->setCurrentFragmentProcedure(Lcom/taobao/monitor/procedure/IProcedure;)V

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v1, "loadStartTime"

    .line 3
    invoke-interface {v0, v1, p2, p3}, Lcom/taobao/monitor/procedure/IProcedure;->stage(Ljava/lang/String;J)Lcom/taobao/monitor/procedure/IProcedure;

    .line 5
    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    .line 6
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "timestamp"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onFragmentPreAttached"

    .line 7
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Landroidx/fragment/app/Fragment;

    iput-wide p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:J

    .line 11
    invoke-direct {p0, p1}, Lcom/taobao/monitor/impl/processor/fragmentload/d;->c(Landroidx/fragment/app/Fragment;)V

    .line 13
    invoke-static {}, Lcom/taobao/monitor/impl/data/r/a;->a()[J

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:[J

    return-void
.end method

.method public l(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentPaused"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public m(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentPreCreated"

    .line 3
    invoke-interface {p2, p3, p1}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method

.method public n(Landroidx/fragment/app/Fragment;J)V
    .locals 1

    .line 1
    new-instance p1, Ljava/util/HashMap;

    const/4 v0, 0x1

    invoke-direct {p1, v0}, Ljava/util/HashMap;-><init>(I)V

    .line 2
    invoke-static {p2, p3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    const-string p3, "timestamp"

    invoke-virtual {p1, p3, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p2, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string p3, "onFragmentAttached"

    .line 3
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

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/fragmentload/d;->a:Lcom/taobao/monitor/procedure/IProcedure;

    const-string v2, "onLowMemory"

    .line 3
    invoke-interface {v1, v2, v0}, Lcom/taobao/monitor/procedure/IProcedure;->event(Ljava/lang/String;Ljava/util/Map;)Lcom/taobao/monitor/procedure/IProcedure;

    return-void
.end method
