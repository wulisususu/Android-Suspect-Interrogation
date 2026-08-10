.class public Lcom/taobao/monitor/impl/trace/c;
.super Lcom/taobao/monitor/impl/trace/a;
.source "ActivityLifeCycleDispatcher.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/trace/c$s;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/trace/a<",
        "Lcom/taobao/monitor/impl/trace/c$s;",
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
.method public a(Landroid/app/Activity;J)V
    .locals 1

    .line 2
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$h;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$h;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public a(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/monitor/impl/trace/c$k;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/c$k;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;Landroid/os/Bundle;J)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public b(Landroid/app/Activity;J)V
    .locals 1

    .line 2
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$b;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$b;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public b(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/monitor/impl/trace/c$l;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/c$l;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;Landroid/os/Bundle;J)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public c(Landroid/app/Activity;J)V
    .locals 1

    .line 2
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$i;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$i;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public c(Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 7

    .line 1
    new-instance v6, Lcom/taobao/monitor/impl/trace/c$j;

    move-object v0, v6

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-wide v4, p3

    invoke-direct/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/c$j;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;Landroid/os/Bundle;J)V

    invoke-virtual {p0, v6}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public d(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$c;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$c;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public e(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$r;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$r;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public f(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$o;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$o;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public g(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$f;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$f;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public h(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$g;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$g;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public i(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$a;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$a;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public j(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$p;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$p;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public k(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$m;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$m;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public l(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$d;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$d;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public m(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$q;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$q;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public n(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$n;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$n;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method

.method public o(Landroid/app/Activity;J)V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/c$e;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/taobao/monitor/impl/trace/c$e;-><init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;J)V

    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method
