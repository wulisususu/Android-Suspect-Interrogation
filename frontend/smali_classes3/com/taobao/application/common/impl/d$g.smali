.class Lcom/taobao/application/common/impl/d$g;
.super Ljava/lang/Object;
.source "ApplicationCallbackGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/d;->onActivityDestroyed(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/Activity;

.field final synthetic a:Lcom/taobao/application/common/impl/d;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/d;Landroid/app/Activity;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/d$g;->a:Lcom/taobao/application/common/impl/d;

    iput-object p2, p0, Lcom/taobao/application/common/impl/d$g;->a:Landroid/app/Activity;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/application/common/impl/d$g;->a:Lcom/taobao/application/common/impl/d;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/d;->a(Lcom/taobao/application/common/impl/d;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Application$ActivityLifecycleCallbacks;

    iget-object v2, p0, Lcom/taobao/application/common/impl/d$g;->a:Landroid/app/Activity;

    .line 2
    invoke-interface {v1, v2}, Landroid/app/Application$ActivityLifecycleCallbacks;->onActivityDestroyed(Landroid/app/Activity;)V

    goto :goto_0

    :cond_0
    return-void
.end method
