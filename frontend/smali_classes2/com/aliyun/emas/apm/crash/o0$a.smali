.class Lcom/aliyun/emas/apm/crash/o0$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/aliyun/emas/apm/crash/o0$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/o0;->toString()Ljava/lang/String;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field a:Z

.field final synthetic b:Ljava/lang/StringBuilder;

.field final synthetic c:Lcom/aliyun/emas/apm/crash/o0;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/o0;Ljava/lang/StringBuilder;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/o0$a;->c:Lcom/aliyun/emas/apm/crash/o0;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/o0$a;->b:Ljava/lang/StringBuilder;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/o0$a;->a:Z

    return-void
.end method


# virtual methods
.method public a(Ljava/io/InputStream;I)V
    .locals 1

    iget-boolean p1, p0, Lcom/aliyun/emas/apm/crash/o0$a;->a:Z

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/o0$a;->a:Z

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0$a;->b:Ljava/lang/StringBuilder;

    const-string v0, ", "

    .line 4
    invoke-virtual {p1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :goto_0
    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/o0$a;->b:Ljava/lang/StringBuilder;

    .line 6
    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    return-void
.end method
