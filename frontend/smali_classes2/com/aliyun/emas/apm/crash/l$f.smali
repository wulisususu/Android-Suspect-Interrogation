.class Lcom/aliyun/emas/apm/crash/l$f;
.super Landroid/content/BroadcastReceiver;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/l;->a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/c1;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/c1;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/l;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/l;Lcom/aliyun/emas/apm/crash/c1;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l$f;->b:Lcom/aliyun/emas/apm/crash/l;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/l$f;->a:Lcom/aliyun/emas/apm/crash/c1;

    .line 1
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/l0;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p2

    .line 2
    invoke-static {p1}, Lcom/aliyun/emas/apm/crash/l0;->b(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    .line 3
    new-instance v0, Lcom/aliyun/emas/apm/crash/k0;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/k0;-><init>()V

    .line 4
    invoke-virtual {v0, p2}, Lcom/aliyun/emas/apm/crash/k0;->b(Ljava/lang/String;)V

    .line 5
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/k0;->a(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/l$f;->a:Lcom/aliyun/emas/apm/crash/c1;

    .line 6
    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/c1;->a(Lcom/aliyun/emas/apm/crash/k0;)V

    return-void
.end method
