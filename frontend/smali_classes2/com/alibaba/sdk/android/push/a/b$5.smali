.class Lcom/alibaba/sdk/android/push/a/b$5;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/b;->setDoNotDisturb(IIIILcom/alibaba/sdk/android/push/CommonCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:I

.field final synthetic c:I

.field final synthetic d:I

.field final synthetic e:Lcom/alibaba/sdk/android/push/CommonCallback;

.field final synthetic f:Lcom/alibaba/sdk/android/push/a/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/b;IIIILcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$5;->f:Lcom/alibaba/sdk/android/push/a/b;

    iput p2, p0, Lcom/alibaba/sdk/android/push/a/b$5;->a:I

    iput p3, p0, Lcom/alibaba/sdk/android/push/a/b$5;->b:I

    iput p4, p0, Lcom/alibaba/sdk/android/push/a/b$5;->c:I

    iput p5, p0, Lcom/alibaba/sdk/android/push/a/b$5;->d:I

    iput-object p6, p0, Lcom/alibaba/sdk/android/push/a/b$5;->e:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/b$5;->f:Lcom/alibaba/sdk/android/push/a/b;

    invoke-static {v0}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;)Lcom/alibaba/sdk/android/push/a/a;

    move-result-object v1

    iget v2, p0, Lcom/alibaba/sdk/android/push/a/b$5;->a:I

    iget v3, p0, Lcom/alibaba/sdk/android/push/a/b$5;->b:I

    iget v4, p0, Lcom/alibaba/sdk/android/push/a/b$5;->c:I

    iget v5, p0, Lcom/alibaba/sdk/android/push/a/b$5;->d:I

    iget-object v6, p0, Lcom/alibaba/sdk/android/push/a/b$5;->e:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-virtual/range {v1 .. v6}, Lcom/alibaba/sdk/android/push/a/a;->a(IIIILcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method
