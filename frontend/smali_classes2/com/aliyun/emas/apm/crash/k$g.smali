.class Lcom/aliyun/emas/apm/crash/k$g;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/k;->a(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/k;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/k$g;->b:Lcom/aliyun/emas/apm/crash/k;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/k$g;->a:Ljava/lang/String;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Void;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/k$g;->b:Lcom/aliyun/emas/apm/crash/k;

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/k$g;->a:Ljava/lang/String;

    .line 1
    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/k;->a(Lcom/aliyun/emas/apm/crash/k;Ljava/lang/String;Ljava/lang/Boolean;)V

    const/4 v0, 0x0

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/k$g;->a()Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method
