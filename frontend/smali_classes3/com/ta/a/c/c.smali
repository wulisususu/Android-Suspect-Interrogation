.class public Lcom/ta/a/c/c;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static a:Ljava/io/File;

.field private static a:Ljava/nio/channels/FileChannel;

.field private static a:Ljava/nio/channels/FileLock;

.field private static b:Ljava/io/File;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public static declared-synchronized c()V
    .locals 4

    const-class v0, Lcom/ta/a/c/c;

    monitor-enter v0

    .line 24
    :try_start_0
    invoke-static {}, Lcom/ta/a/c/f;->e()V

    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/io/File;

    if-nez v1, :cond_0

    .line 26
    new-instance v1, Ljava/io/File;

    invoke-static {}, Lcom/ta/a/b/e;->c()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    sput-object v1, Lcom/ta/a/c/c;->a:Ljava/io/File;

    :cond_0
    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/io/File;

    .line 28
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    if-nez v1, :cond_1

    :try_start_1
    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/io/File;

    .line 31
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_0

    .line 33
    :catch_0
    monitor-exit v0

    return-void

    :cond_1
    :goto_0
    :try_start_2
    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileChannel;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    if-nez v1, :cond_2

    .line 38
    :try_start_3
    new-instance v1, Ljava/io/RandomAccessFile;

    sget-object v2, Lcom/ta/a/c/c;->a:Ljava/io/File;

    const-string v3, "rw"

    invoke-direct {v1, v2, v3}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v1

    sput-object v1, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileChannel;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    .line 40
    :catch_1
    monitor-exit v0

    return-void

    :cond_2
    :goto_1
    :try_start_4
    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileChannel;

    .line 44
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->lock()Ljava/nio/channels/FileLock;

    move-result-object v1

    sput-object v1, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileLock;
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 48
    :catchall_0
    monitor-exit v0

    return-void

    :catchall_1
    move-exception v1

    monitor-exit v0

    throw v1
.end method

.method public static declared-synchronized d()V
    .locals 3

    const-class v0, Lcom/ta/a/c/c;

    monitor-enter v0

    .line 51
    :try_start_0
    invoke-static {}, Lcom/ta/a/c/f;->e()V

    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileLock;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 54
    :try_start_1
    invoke-virtual {v1}, Ljava/nio/channels/FileLock;->release()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catch_0
    :try_start_2
    sput-object v2, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileLock;

    goto :goto_0

    :catchall_0
    move-exception v1

    sput-object v2, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileLock;

    .line 58
    throw v1

    :cond_0
    :goto_0
    sget-object v1, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileChannel;
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    if-eqz v1, :cond_1

    .line 63
    :try_start_3
    invoke-virtual {v1}, Ljava/nio/channels/FileChannel;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    :catch_1
    :try_start_4
    sput-object v2, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileChannel;

    goto :goto_1

    :catchall_1
    move-exception v1

    sput-object v2, Lcom/ta/a/c/c;->a:Ljava/nio/channels/FileChannel;

    .line 67
    throw v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 70
    :cond_1
    :goto_1
    monitor-exit v0

    return-void

    :catchall_2
    move-exception v1

    monitor-exit v0

    throw v1
.end method
