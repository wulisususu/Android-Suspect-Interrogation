.class public Lcom/taobao/monitor/impl/trace/b;
.super Lcom/taobao/monitor/impl/trace/a;
.source "ActivityEventDispatcher.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/trace/b$c;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/trace/a<",
        "Lcom/taobao/monitor/impl/trace/b$c;",
        ">;"
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Activity;Landroid/view/KeyEvent;J)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/monitor/impl/trace/b$a;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/b$a;-><init>(Lcom/taobao/monitor/impl/trace/b;Landroid/app/Activity;Landroid/view/KeyEvent;J)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/view/MotionEvent;J)V
    .locals 7

    .line 2
    new-instance v6, Lcom/taobao/monitor/impl/trace/b$b;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/b$b;-><init>(Lcom/taobao/monitor/impl/trace/b;Landroid/app/Activity;Landroid/view/MotionEvent;J)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method
