.class Lcom/taobao/application/common/impl/c$a;
.super Ljava/lang/Object;
.source "AppLaunchListenerGroup.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/application/common/impl/c;->a(Lcom/taobao/application/common/IAppLaunchListener;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/application/common/IAppLaunchListener;

.field final synthetic a:Lcom/taobao/application/common/impl/c;


# direct methods
.method constructor <init>(Lcom/taobao/application/common/impl/c;Lcom/taobao/application/common/IAppLaunchListener;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/application/common/impl/c$a;->a:Lcom/taobao/application/common/impl/c;

    iput-object p2, p0, Lcom/taobao/application/common/impl/c$a;->a:Lcom/taobao/application/common/IAppLaunchListener;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/application/common/impl/c$a;->a:Lcom/taobao/application/common/impl/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/application/common/impl/c;->a(Lcom/taobao/application/common/impl/c;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/c$a;->a:Lcom/taobao/application/common/IAppLaunchListener;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/application/common/impl/c$a;->a:Lcom/taobao/application/common/impl/c;

    .line 2
    invoke-static {v0}, Lcom/taobao/application/common/impl/c;->a(Lcom/taobao/application/common/impl/c;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/application/common/impl/c$a;->a:Lcom/taobao/application/common/IAppLaunchListener;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method
