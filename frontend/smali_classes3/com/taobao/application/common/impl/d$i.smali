.class Lcom/taobao/application/common/impl/d$i;
.super Ljava/lang/Object;
.source "ApplicationCallbackGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/d;->b(Landroid/app/Application$ActivityLifecycleCallbacks;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/app/Application$ActivityLifecycleCallbacks;

.field final synthetic a:Lcom/taobao/application/common/impl/d;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/d;Landroid/app/Application$ActivityLifecycleCallbacks;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/d$i;->a:Lcom/taobao/application/common/impl/d;

    iput-object p2, p0, Lcom/taobao/application/common/impl/d$i;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/application/common/impl/d$i;->a:Lcom/taobao/application/common/impl/d;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/d;->a(Lcom/taobao/application/common/impl/d;)Ljava/util/ArrayList;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/d$i;->a:Landroid/app/Application$ActivityLifecycleCallbacks;

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    return-void
.end method
