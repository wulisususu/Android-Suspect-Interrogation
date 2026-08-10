.class Lcom/taobao/monitor/impl/trace/b$a;
.super Ljava/lang/Object;
.source "ActivityEventDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/b;->a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/b$c;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Landroid/app/Activity;

.field final synthetic a:Landroid/view/KeyEvent;

.field final synthetic a:Lcom/taobao/monitor/impl/trace/b;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/b;Landroid/app/Activity;Landroid/view/KeyEvent;J)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:Lcom/taobao/monitor/impl/trace/b;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:Landroid/view/KeyEvent;

    iput-wide p4, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/b$c;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:Landroid/view/KeyEvent;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/trace/b$a;->a:J

    .line 2
    invoke-interface {p1, v0, v1, v2, v3}, Lcom/taobao/monitor/impl/trace/b$c;->a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/b$c;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/b$a;->a(Lcom/taobao/monitor/impl/trace/b$c;)V

    return-void
.end method
