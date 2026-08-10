.class Lcom/taobao/application/common/impl/d;
.super Ljava/lang/Object;
.source "ApplicationCallbackGroup.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;
.implements Lcom/taobao/application/common/impl/e;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/app/Application$ActivityLifecycleCallbacks;",
        "Lcom/taobao/application/common/impl/e<",
        "Landroid/app/Application$ActivityLifecycleCallbacks;",
        ">;"
    }
.end annotation


# instance fields
.field private final a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/app/Application$ActivityLifecycleCallbacks;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 3
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/taobao/application/common/impl/d;->a:Ljava/util/ArrayList;

    return-void
.end method

.method static synthetic a(Lcom/taobao/application/common/impl/d;)Ljava/util/ArrayList;
    .locals 0

    .line 2
    iget-object p0, p0, Lcom/taobao/application/common/impl/d;->a:Ljava/util/ArrayList;

    return-object p0
.end method

.method private a(Ljava/lang/Runnable;)V
    .locals 1

    .line 5
    invoke-static {}, Lcom/taobao/application/common/impl/b;->a()Lcom/taobao/application/common/impl/b;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/application/common/impl/b;->a(Ljava/lang/Runnable;)V

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Application$ActivityLifecycleCallbacks;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 3
    new-instance v0, Lcom/taobao/application/common/impl/d$h;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$h;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Application$ActivityLifecycleCallbacks;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void

    .line 4
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Landroid/app/Application$ActivityLifecycleCallbacks;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/d;->a(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    return-void
.end method

.method public b(Landroid/app/Application$ActivityLifecycleCallbacks;)V
    .locals 1

    if-eqz p1, :cond_0

    .line 2
    new-instance v0, Lcom/taobao/application/common/impl/d$i;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$i;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Application$ActivityLifecycleCallbacks;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void

    .line 3
    :cond_0
    new-instance p1, Ljava/lang/IllegalArgumentException;

    invoke-direct {p1}, Ljava/lang/IllegalArgumentException;-><init>()V

    throw p1
.end method

.method public bridge synthetic b(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Landroid/app/Application$ActivityLifecycleCallbacks;

    invoke-virtual {p0, p1}, Lcom/taobao/application/common/impl/d;->b(Landroid/app/Application$ActivityLifecycleCallbacks;)V

    return-void
.end method

.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$a;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/application/common/impl/d$a;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;Landroid/os/Bundle;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$g;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$g;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$d;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$d;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$c;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$c;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$f;

    invoke-direct {v0, p0, p1, p2}, Lcom/taobao/application/common/impl/d$f;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;Landroid/os/Bundle;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$b;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$b;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/application/common/impl/d$e;

    invoke-direct {v0, p0, p1}, Lcom/taobao/application/common/impl/d$e;-><init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;)V

    invoke-direct {p0, v0}, Lcom/taobao/application/common/impl/d;->a(Ljava/lang/Runnable;)V

    return-void
.end method
