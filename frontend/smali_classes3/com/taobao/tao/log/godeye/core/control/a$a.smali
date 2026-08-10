.class Lcom/taobao/tao/log/godeye/core/control/a$a;
.super Landroid/os/Handler;
.source "GodeyeJointPointCenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/control/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field private final a:Lcom/taobao/tao/log/godeye/api/b/c$a;


# direct methods
.method constructor <init>(Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 0

    .line 451
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$a;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 0

    .line 457
    invoke-super {p0, p1}, Landroid/os/Handler;->handleMessage(Landroid/os/Message;)V

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$a;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 458
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    return-void
.end method
