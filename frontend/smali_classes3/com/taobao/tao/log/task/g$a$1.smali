.class Lcom/taobao/tao/log/task/g$a$1;
.super Ljava/lang/Object;
.source "HeapDumpReplyTask.java"

# interfaces
.implements Lcom/taobao/tao/log/upload/FileUploadListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/tao/log/task/g$a;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/tao/log/task/g$a;


# direct methods
.method constructor <init>(Lcom/taobao/tao/log/task/g$a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/task/g$a$1;->a:Lcom/taobao/tao/log/task/g$a;

    .line 173
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/task/g$a$1;->a:Lcom/taobao/tao/log/task/g$a;

    .line 176
    invoke-static {v0}, Lcom/taobao/tao/log/task/g$a;->a(Lcom/taobao/tao/log/task/g$a;)Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;

    move-result-object v0

    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;->onError(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public onSucessed(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/task/g$a$1;->a:Lcom/taobao/tao/log/task/g$a;

    .line 181
    invoke-static {v0}, Lcom/taobao/tao/log/task/g$a;->a(Lcom/taobao/tao/log/task/g$a;)Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;->onSucess(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method
