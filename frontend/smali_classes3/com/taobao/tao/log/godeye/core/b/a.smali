.class public Lcom/taobao/tao/log/godeye/core/b/a;
.super Ljava/lang/Object;
.source "PluginManager.java"


# static fields
.field private static final a:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final a:[Ljava/lang/String;

.field private static g:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 34
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    sput-object v0, Lcom/taobao/tao/log/godeye/core/b/a;->a:Ljava/util/HashSet;

    const-string v0, "com.taobao.tao.log.godeye.methodtrace.MethodTraceInitializer"

    const-string v1, "com.taobao.tao.log.godeye.memorydump.MemoryDumpInitializer"

    .line 39
    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/taobao/tao/log/godeye/core/b/a;->a:[Ljava/lang/String;

    const/4 v0, 0x0

    sput-boolean v0, Lcom/taobao/tao/log/godeye/core/b/a;->g:Z

    return-void
.end method

.method private static a(Ljava/io/File;)Ljava/util/ArrayList;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            ")",
            "Ljava/util/ArrayList<",
            "Lcom/taobao/tao/log/godeye/core/b/a/b$a;",
            ">;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 80
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v1, Ljava/io/InputStreamReader;

    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, p0}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    const-string p0, "UTF-8"

    invoke-direct {v1, v2, p0}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 83
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 85
    :cond_0
    :goto_0
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    const-string v2, ""

    .line 86
    invoke-virtual {v2, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_0

    .line 87
    new-instance v2, Lcom/taobao/tao/log/godeye/core/b/a/b$a;

    invoke-direct {v2}, Lcom/taobao/tao/log/godeye/core/b/a/b$a;-><init>()V

    .line 88
    invoke-virtual {v2, v1}, Lcom/taobao/tao/log/godeye/core/b/a/b$a;->b(Ljava/lang/String;)V

    .line 89
    invoke-virtual {p0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 92
    :cond_1
    invoke-virtual {v0}, Ljava/io/BufferedReader;->close()V

    return-object p0
.end method

.method public static a(Landroid/app/Application;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 51
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "godeye.plugin.cfg"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 52
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v2

    invoke-virtual {v2}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->getAppVersion()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 53
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_0

    .line 54
    invoke-static {v0}, Lcom/taobao/tao/log/godeye/core/b/a;->a(Ljava/io/File;)Ljava/util/ArrayList;

    move-result-object p0

    .line 55
    invoke-virtual {p0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_0
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/tao/log/godeye/core/b/a/b$a;

    .line 56
    new-instance v1, Lcom/taobao/tao/log/godeye/core/b/a/a;

    invoke-direct {v1, v0}, Lcom/taobao/tao/log/godeye/core/b/a/a;-><init>(Lcom/taobao/tao/log/godeye/core/b/a/b$a;)V

    .line 57
    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/core/b/a/b;->execute()V

    sget-object v1, Lcom/taobao/tao/log/godeye/core/b/a;->a:Ljava/util/HashSet;

    .line 58
    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/b/a/b$a;->c()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_0
    return-void
.end method

.method public static b(Landroid/app/Application;)V
    .locals 3

    .line 67
    new-instance v0, Ljava/io/File;

    invoke-virtual {p0}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object p0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "godeye.plugin.cfg"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 68
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v2

    invoke-virtual {v2}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->getAppVersion()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 69
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result p0

    if-eqz p0, :cond_0

    .line 70
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    :cond_0
    const/4 p0, 0x0

    sput-boolean p0, Lcom/taobao/tao/log/godeye/core/b/a;->g:Z

    return-void
.end method

.method public static c()V
    .locals 8
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    sget-boolean v0, Lcom/taobao/tao/log/godeye/core/b/a;->g:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/taobao/tao/log/godeye/core/b/a;->a:[Ljava/lang/String;

    .line 104
    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    const/4 v4, 0x1

    if-ge v2, v1, :cond_2

    aget-object v5, v0, v2

    sget-object v6, Lcom/taobao/tao/log/godeye/core/b/a;->a:Ljava/util/HashSet;

    .line 105
    invoke-virtual {v6, v5}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_1

    .line 106
    new-instance v3, Lcom/taobao/tao/log/godeye/core/b/a/b$a;

    invoke-direct {v3}, Lcom/taobao/tao/log/godeye/core/b/a/b$a;-><init>()V

    .line 107
    invoke-virtual {v3, v5}, Lcom/taobao/tao/log/godeye/core/b/a/b$a;->b(Ljava/lang/String;)V

    .line 108
    new-instance v7, Lcom/taobao/tao/log/godeye/core/b/a/a;

    invoke-direct {v7, v3}, Lcom/taobao/tao/log/godeye/core/b/a/a;-><init>(Lcom/taobao/tao/log/godeye/core/b/a/b$a;)V

    invoke-virtual {v7}, Lcom/taobao/tao/log/godeye/core/b/a/a;->execute()V

    .line 109
    invoke-virtual {v6, v5}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move v3, v4

    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_2
    if-eqz v3, :cond_4

    .line 115
    new-instance v0, Ljava/io/File;

    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->getApplication()Landroid/app/Application;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/Application;->getFilesDir()Ljava/io/File;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "godeye.plugin.cfg"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 116
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v3

    invoke-virtual {v3}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->getAppVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 117
    new-instance v1, Ljava/io/BufferedWriter;

    new-instance v2, Ljava/io/FileWriter;

    invoke-direct {v2, v0}, Ljava/io/FileWriter;-><init>(Ljava/io/File;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    const-string v0, ""

    .line 118
    invoke-virtual {v1, v0}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    sget-object v0, Lcom/taobao/tao/log/godeye/core/b/a;->a:Ljava/util/HashSet;

    .line 119
    invoke-virtual {v0}, Ljava/util/HashSet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 120
    invoke-virtual {v1, v2}, Ljava/io/BufferedWriter;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/io/Writer;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    goto :goto_1

    .line 122
    :cond_3
    invoke-virtual {v1}, Ljava/io/BufferedWriter;->flush()V

    .line 123
    invoke-virtual {v1}, Ljava/io/BufferedWriter;->close()V

    :cond_4
    sput-boolean v4, Lcom/taobao/tao/log/godeye/core/b/a;->g:Z

    return-void
.end method
